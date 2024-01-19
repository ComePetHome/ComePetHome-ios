//
//  UserViewModel.swift
//  ComePetHome
//
//  Created by 주진형 on 1/10/24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    @Published var savedUser = SavedUser(userId: "", nickName: "", imageUrl: "", name: "", phoneNumber: "")
    @Published var user = User(userId: "", password: "", nickName: "", name: "", phoneNumber: "")
    @Published var isLogin: Bool = false
    @Published var findId: String = ""
    func postSignUp(user:User) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            
            // URL 설정
            guard let url = URL(string: "http://13.124.211.208:9001/api/user/command/join") else {
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
    
    func getLogin(id: String, password: String) {
        let parameters = [
            "userId": id,
            "password": password
        ]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            
            var request = URLRequest(url: URL(string: "http://13.124.211.208:9001/api/user/command/login")!,timeoutInterval: Double.infinity)
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
                                print("Message: \(message)")
                                DispatchQueue.main.async {
                                    if message == "회원이 정상 로그인되었습니다." {
                                        self.isLogin = true
                                        self.getUser(id:id)
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
            var request = URLRequest(url: URL(string: "http://13.124.211.208:9001/api/user/query/profile")!)
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
            
                var request = URLRequest(url: URL(string: "http://13.124.211.208:9001/api/user/query/findUserId")!,timeoutInterval: Double.infinity)
                
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
                                    self.findId = message
                                }
                                
                                // 여기서 딕셔너리를 사용하여 원하는 작업을 수행할 수 있습니다.
                                if let message = jsonObject["userId"] as? String {
                                    print("Message: \(message)")
                                    self.findId = message
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
    
    func modifyProfile(user: SavedUser) {
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(user)
            
            guard let url = URL(string: "http://3.36.75.87:9001/api/user/command/profile") else {
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
}
struct ContentView: View {
    @ObservedObject var userViewModel = UserViewModel()
    var body: some View {
        VStack {
            Text(userViewModel.savedUser.userId)
            Text(userViewModel.findId)
            Button("회원 가입") {
                userViewModel.postSignUp(user: User(userId: "test", password: "123", nickName: "test", name: "test", phoneNumber: "010-0000-0000"))
            }
            Button("로그인") {
                userViewModel.getLogin(id: "testiOS2", password: "123")
            }
            Button("정보 가져오기") {
                userViewModel.getUser(id: "testiOS")
                print(userViewModel.savedUser)
            }
            Button("id찾기") {
                userViewModel.findMyId(name: "123", phoneNumber: "010-1231-123")
            }
            Button("정보수정하기") {
                userViewModel.modifyProfile(user: SavedUser(userId: "testiOS", nickName: "iOS", imageUrl: "", name: "iOS", phoneNumber: "010-2222-2222"))
            }
        }
    }
}

#Preview {
    ContentView()
}
