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
    func fetchPets() {
        guard let url = URL(string: "http://3.36.75.87:9001/pets") else {
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
                let decodedPets = try decoder.decode([Pet].self, from: data)
                
                DispatchQueue.main.async {
                    self.pets = decodedPets
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
}

//struct ContentView: View {
//    @ObservedObject var petViewModel = PetViewModel()
//    var body: some View {
//        
//        List(petViewModel.pets, id: \.pet_id) { pet in
//            VStack(alignment: .leading) {
//                Text("Name: \(pet.name)")
//                Text("Center: \(pet.center)")
//                // date의 값이 "yyyy-MM-dd'T'HH:mm:ss.SSSZ"의 형태로 받아지고 있어, 앞에서 10자리를 끊은 날짜 값을 출력한다.
//                Text("Enlistment Date: \(String("\(pet.enlistment_date)".prefix(10)))")
//                Text("Breeds: \(pet.breeds)")
//                Text("Sex: \(pet.sex)")
//                Text("Age: \(pet.age.replacingOccurrences(of: "[()]", with: "", options: .regularExpression))")
//                Text("Adoption Status: \(pet.adp_status)")
//                Text("Like: \(pet.like ? "Yes" : "No")")
//                
//            }
//        }
//        .onAppear {
//            petViewModel.fetchPets()
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
