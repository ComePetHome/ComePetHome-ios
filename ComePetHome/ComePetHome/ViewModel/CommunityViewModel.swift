//
//  ArticleViewModel.swift
//  ComePetHome
//
//  Created by 주진형 on 1/12/24.
//

import Foundation
import SwiftUI

class CommunityViewModel: ObservableObject {
    @Published var communityList: [Community] = []
    @Published var communityInfo: CommunityInfo?
    
    func fetchCommunity(sort: String, category: String) {
        guard let url = URL(string: "http://54.180.142.14:9001/pet/community?sort=\(sort)&category=\(category)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("*/*", forHTTPHeaderField: "accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            // Print received data to check its validity
            print("Received data:", data)
            
            do {
                let decoder = JSONDecoder()
                let decodedcommunities = try decoder.decode([Community].self, from: data)
                
                DispatchQueue.main.async {
                    self.communityList = decodedcommunities
                    print(self.communityList)
                }
            } catch let decodingError {
                print("Error decoding JSON:", decodingError)
            }
        }
        task.resume()
    }
    
    func fetchCommunityInfo(communityId: Int) {
        guard let url = URL(string: "http://54.180.142.14:9001/pet/community/info/\(communityId)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("*/*", forHTTPHeaderField: "accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received.")
                return
            }
            
            // Print received data to check its validity
            print("Received data:", data)
            
            do {
                let decoder = JSONDecoder()
                let decodedcommunityInfo = try decoder.decode(CommunityInfo.self, from: data)
                
                DispatchQueue.main.async {
                    self.communityInfo = decodedcommunityInfo
                    print(self.communityInfo as Any)
                }
            } catch let decodingError {
                print("Error decoding JSON:", decodingError)
            }
        }
        task.resume()
    }
    
    func postComment(communityId: Int, comment: String) {
        let parameters = [
            "contents": comment,
            "article_id": communityId
        ] as [String : Any]
        do {
            let postData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            guard let url = URL(string: "http://54.180.142.14:9001/pet/community/comment") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = postData
            request.addValue("*/*", forHTTPHeaderField: "accept")
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
                            }
                            // 여기서 딕셔너리를 사용하여 원하는 작업을 수행할 수 있습니다.
                            if let message = jsonObject["userId"] as? String {
                                print("Message: \(message)")
                            }
                        }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                }
            }
            task.resume()
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}
struct ContentView2: View {
    @StateObject var communityVM = CommunityViewModel()
    var body: some View {
        VStack{
            
        }
        .onAppear {
            communityVM.fetchCommunityInfo(communityId: 13)
        }
    }
}

#Preview {
    ContentView2()
}
