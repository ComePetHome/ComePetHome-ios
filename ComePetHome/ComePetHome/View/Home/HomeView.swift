//
//  ContentView.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import SwiftUI

struct HomeView: View {
    let logoImage = UIImage(named: "ComePetHomeLogo")
    @ObservedObject var petViewModel = PetViewModel()
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                    ForEach(petViewModel.pets, id: \.pet_id) { pet in
                        NavigationLink {
                            AnimalDetailView(animalName: pet.name, animalBreeds: pet.breeds, animalAge:pet.age, isLike: pet.like)
                        } label: {
                            AnimalFreeView(animalName: pet.name, animalAge: pet.age, animalSex: pet.sex, animalCenter: pet.center, isLike: pet.like)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                        }
                    }
                }
                .padding()
            }
            .onAppear {
                petViewModel.fetchPets()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(uiImage: UIImage(named: "ComePetHomeLogo")!)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
    }
    
}


#Preview {
    HomeView()
}
