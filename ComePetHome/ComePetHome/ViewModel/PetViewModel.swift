//
//  AnimalData.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import Foundation
import SwiftUI

class PetViewModel: ObservableObject {
    @Published var pets: [Pet] = []
    @Published var searchedPets: [Pet] = []
    @Published var petDetail: PetDetail?
    //PetDetail(pet_id: 0, name: "", center: "", enlistment_date: "", breeds: "", sex: "", age: "", adp_status: "", species: "", weight: 0.0, intro_url: "", intro_contents: "", thumbnail_url: "", created_at: "", updated_at: "")
    @Published var petDetail2: PetDetail?
    @Published var petAppendDetail: [Pet: PetDetail] = [:]
    private var currentPage = 0
    
    func fetchPets(pageNumber: Int = 0) {
        guard let url = URL(string: "http://54.180.142.14:9001/pet/pets?pageNumber=\(currentPage)") else {
            return
        }
        var request = URLRequest(url: url)
        //guard let authToken = UserDefaults.standard.string(forKey: "AuthToken") else { return } 
        
        //request.addValue("\(authToken)", forHTTPHeaderField: "access-token")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "accept")
        //request.addValue("speed", forHTTPHeaderField: "userId")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
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
                let decodedPets = try decoder.decode([Pet].self, from: data)
                
                DispatchQueue.main.async {
                    self.pets.append(contentsOf: decodedPets)
                    self.currentPage += 1
                    for pet in self.pets {
                        self.fetchPetDetail(pet: pet)
                    }
                }
                
            } catch let decodingError {
                print("Error decoding JSON:", decodingError)
            }
        }.resume()
    }
    
    func fetchPetDetail(pet: Pet) {
        guard let url = URL(string: "http://54.180.142.14:9001/pet/pets/\(pet.pet_id)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
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
                let decodedPets = try decoder.decode(PetDetail.self, from: data)
                
                DispatchQueue.main.async {
                    self.petDetail = decodedPets
                    self.petAppendDetail[pet] = self.petDetail
                }
            } catch let decodingError {
                print("Error decoding JSON:", decodingError)
            }
        }.resume()
    }
    
    func findPets(searchKeyword: String) {
        searchedPets.removeAll()
        fetchPets()
        for pet in pets {
            if pet.center.hasPrefix(searchKeyword) || pet.breeds.hasSuffix(searchKeyword) || pet.name.hasSuffix(searchKeyword) {
                searchedPets.append(pet)
            }
        }
    }
    
    func toggleLikeForPet(petID: Int, userID: String) {
        // 요청 URL
        let urlString = "http://54.180.142.14:9001/pet/pets/like/\(petID)"
        
        // URL 객체 생성
        if let url = URL(string: urlString) {
            // URLRequest 생성
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            // HTTP 헤더 설정
            request.addValue("*/*", forHTTPHeaderField: "accept")
            request.addValue(userID, forHTTPHeaderField: "userId")
            
            // URLSession을 통한 데이터 전송
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // 에러 처리
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                // 성공적인 응답 처리
                if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                    print("Like toggled successfully!")
                } else {
                    print("Unexpected response.")
                }
            }
            
            // 데이터 전송 시작
            task.resume()
        } else {
            print("Invalid URL.")
        }
    }
}


