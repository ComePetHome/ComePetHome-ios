//
//  ArticleViewModel.swift
//  ComePetHome
//
//  Created by 주진형 on 1/12/24.
//

import Foundation

class CommunityViewModel: ObservableObject {
    @Published var communityList: [Community] = []
    
    func fetchCommunity(sort: String, category: String) {
        guard let url = URL(string: "http://54.180.142.14:9001/pet/community?sort=\(sort)&category=\(category)") else { return }
        var requst = URLRequest(url: url)
        requst.httpMethod = "GET"
        requst.addValue("*/*", forHTTPHeaderField: "accept")
        
        let task = URLSession.shared.dataTask(with: requst) { data, response, error in
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
}

