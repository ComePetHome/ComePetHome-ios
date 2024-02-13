//
//  UserViewModel.swift
//  ComePetHome
//
//  Created by 주진형 on 1/10/24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var savedUser = SavedUser(userId: "", nickName: "", name: "", phoneNumber: "")
    @Published var user = User(userId: "", password: "", nickName: "", name: "", phoneNumber: "")
    @Published var patchUser = PatchUser(nickName: "", name: "", phoneNumber: "")
    @Published var imageUrl:String = ""
    @Published var isLogin: Bool = false
    @Published var findId: String = ""
    @Published var image: UIImage = UIImage(named: "Dog")!
    @Published var image1: UIImage = UIImage(named: "ComePetHomeLogoImage")!
    
    /// 유저정보
    func postSignUp(user:User) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            
            // URL 설정
            guard let url = URL(string: "http://54.180.142.14:9001/api/user/command/join") else {
                print("Invalid URL")
                return
            }
            
            // URLRequest 생성 및 설정
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            // URLSession을 사용하여 요청 전송
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    // 서버 응답 처리
                    let responseString = String(data: data, encoding: .utf8)
                    print("Server Response: \(responseString ?? "")")
                    // 서버 응답에 대한 추가 처리 작업 수행
                }
            }
            task.resume()
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
        }
    }
    
    func getLogin(id: String, password: String, completion: @escaping (String) -> Void) {
        let parameters = [
            "userId": id,
            "password": password
        ]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: URL(string: "http://54.180.142.14:9001/api/user/command/login")!,timeoutInterval: Double.infinity)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                if let httpResponse = response as? HTTPURLResponse,
                   let token = httpResponse.allHeaderFields["access-token"] as? String {
                    UserDefaults.standard.set(token, forKey: "AuthToken")
                }
                print(String(data: data, encoding: .utf8)!)
                let message = String(data: data, encoding: .utf8)!
                if let jsonData = message.data(using: .utf8) {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            print(jsonObject)
                            
                            // 여기서 딕셔너리를 사용하여 원하는 작업을 수행할 수 있습니다.
                            if let message = jsonObject["message"] as? String {
                                //                                print("message: \(message)")
                                DispatchQueue.main.async {
                                    if message == "회원이 정상 로그인 되었습니다." {
                                        self.isLogin = true
                                        self.getUser(id:id)
                                        self.getImageUrl()
                                        completion(message)
                                    }
                                }
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
                
            }
            task.resume()
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func getUser(id: String) {
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
            var request = URLRequest(url: URL(string: "http://54.180.142.14:9001/api/user/query/profile")!)
            request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let decodedUser = try decoder.decode(SavedUser.self, from: data)
                    DispatchQueue.main.async {
                        self.savedUser = decodedUser
                    }
                } catch let decodingError {
                    print("Error decoding JSON:", decodingError)
                }
                print(String(data: data, encoding: .utf8)!)
            }.resume()
        }
    }
    
    func findMyId(name: String, phoneNumber: String) {
        let parameters = [
            "name": name,
            "phoneNumber": phoneNumber
        ]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: URL(string: "http://54.180.142.14:9001/api/user/query/findUserId")!,timeoutInterval: Double.infinity)
            
            request.httpMethod = "POST"
            request.httpBody = postData
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                print(String(data: data, encoding: .utf8)!)
                let message = String(data: data, encoding: .utf8)!
                if let jsonData = message.data(using: .utf8) {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            //print(jsonObject)
                            if let message = jsonObject["message"] as? String {
                                print("\(message)")
                                DispatchQueue.main.async {
                                    self.findId = message
                                }
                                
                            }
                            
                            // 여기서 딕셔너리를 사용하여 원하는 작업을 수행할 수 있습니다.
                            if let message = jsonObject["userId"] as? String {
                                print("Message: \(message)")
                                DispatchQueue.main.async {
                                    self.findId = message
                                }
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()
            
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func modifyProfile(user: PatchUser) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            
            guard let url = URL(string: "http://54.180.142.14:9001/api/user/command/profile") else {
                print("Invalid URL")
                return
            }
            // URLRequest 생성 및 설정
            if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
                var request = URLRequest(url: url)
                request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
                request.httpMethod = "PATCH"
                request.httpBody = jsonData
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data else {
                        print(String(describing: error))
                        return
                    }
                    print(String(data: data, encoding: .utf8)!)
                }
                task.resume()
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    func userIdCheck(id: String, completion: @escaping (String) -> Void) {
        var request = URLRequest(url: URL(string: "http://54.180.142.14:9001/api/user/query/availableUserId?userId=\(id)")!,timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                return
            }
            completion(String(data: data, encoding: .utf8)!)
            //print(String(data: data, encoding: .utf8)!)
        }
        
        task.resume()
        
    }
    
    func logOut(id: String, password: String) {
        var request = URLRequest(url: URL(string: "http://54.180.142.14:9001/api/user/query/logout")!,timeoutInterval: Double.infinity)
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
            request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                print(String(data: data, encoding: .utf8)!)
                let message = String(data: data, encoding: .utf8)!
                if let jsonData = message.data(using: .utf8) {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any] {
                            print(jsonObject)
                            
                            // 여기서 딕셔너리를 사용하여 원하는 작업을 수행할 수 있습니다.
                            if let message = jsonObject["message"] as? String {
                                //                                print("message: \(message)")
                                DispatchQueue.main.async {
                                    if message == "토큰이 만료 되었습니다." {
                                        self.getLogin(id: id, password: password) { _ in
                                            
                                        }
                                        self.logOut(id: id, password: password)
                                    }
                                }
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            self.isLogin = false
            task.resume()
        }
    }
    
    /// 이미지
    func getImageUrl() {
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
            var request = URLRequest(url: URL(string: "http://54.180.142.14:9001/image/my-profile")!,timeoutInterval: Double.infinity)
            request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
            request.httpMethod = "GET"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print(String(describing: error))
                    return
                }
                //print(String(data: data, encoding: .utf8)! + "1")
                let message = String(data: data, encoding: .utf8)!
                if let jsonData = message.data(using: .utf8) {
                    do {
                        if let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String] {
                            let imageURL = String(jsonObject[0])
                            self.imageUrl = imageURL
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func uploadImage(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        let boundary = "Boundary-\(UUID().uuidString)"
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
            let url = URL(string: "http://54.180.142.14:9001/image/my-profile")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var body = Data()
            
            // 파일 파트 추가
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            
            // 종료 boundary 추가
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    // Process the server response
                    print("Server Response: \(String(data: data, encoding: .utf8) ?? "")")
                }
            }
            
            task.resume()
        }
    }
    func updateImage(image: UIImage){
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            return
        }
        let boundary = "Boundary-\(UUID().uuidString)"
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
            let url = URL(string: "http://54.180.142.14:9001/image/my-profile")!
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var body = Data()
            
            // 파일 파트 추가
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
            
            // 종료 boundary 추가
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    // Process the server response
                    print("Server Response: \(String(data: data, encoding: .utf8) ?? "")")
                    self.getImageUrl()
                }
            }
            
            task.resume()
        }
    }
    
    func deleteImage() {
        let boundary = "Boundary-\(UUID().uuidString)"
        if let authToken = UserDefaults.standard.string(forKey: "AuthToken") {
            let url = URL(string: "http://54.180.142.14:9001/image/my-profile")!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            var body = Data()
            
            // 파일 파트 추가
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"files\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
            
            // 종료 boundary 추가
            body.append("--\(boundary)--\r\n".data(using: .utf8)!)
            
            request.httpBody = body
            
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error uploading image: \(error.localizedDescription)")
                    return
                }
                
                if let data = data {
                    // Process the server response
                    print("Server Response: \(String(data: data, encoding: .utf8) ?? "")")
                    self.imageUrl = ""
                }
            }
            
            task.resume()
        }
    }
}
struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    @State var imageURL = ""
    var body: some View {
        VStack {
            Text(userViewModel.savedUser.userId)
            Text(userViewModel.findId)
            Button("회원 가입") {
                userViewModel.postSignUp(user: User(userId: "testt", password: "123", nickName: "test", name: "test", phoneNumber: "010-0000-1001"))
            }
            .padding()
            Button("로그인") {
                userViewModel.getLogin(id: "speed", password: "1234") { message in
                    print(message)
                }
            }.padding()
            Button("정보 가져오기") {
                userViewModel.getUser(id: "testiOS")
                print(userViewModel.savedUser)
            }.padding()
            Button("id찾기") {
                userViewModel.findMyId(name: "123", phoneNumber: "010-1231-123")
            }.padding()
            Button("정보수정하기") {
                userViewModel.modifyProfile(user: PatchUser(nickName: "스피드01", name: "이름01", phoneNumber: "010-0003-0004"))
            }.padding()
            Button("id 중복체크") {
                userViewModel.userIdCheck(id: "speed") { message in
                    print(message)
                }
            }.padding()
            
            Button("로그아웃") {
                userViewModel.logOut(id: "speed", password: "1234")
                
            }.padding()
            
            Button("image불러오기") {
                userViewModel.getImageUrl()
                
            }.padding()
            Button("image upload") {
                userViewModel.uploadImage(image: userViewModel.image)
            }.padding()
            
            Button("image Delete") {
                userViewModel.deleteImage()
            }.padding()
            
            Button("image Update") {
                userViewModel.updateImage(image: userViewModel.image1)
            }.padding()
            
            
            if userViewModel.imageUrl.isEmpty {
            } else {
                AsyncImage(url: URL(string: userViewModel.imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
            }
        }
        
    }
        
}

#Preview {
    ContentView()
}
