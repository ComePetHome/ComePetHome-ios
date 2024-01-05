//
//  SearchView.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import SwiftUI

struct SearchView: View {
    @State private var searchText = ""
    @ObservedObject private var petViewModel = PetViewModel()
    var body: some View {
        NavigationStack {
            SearchBar(text: $searchText)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
            Spacer()
            VStack {
                if searchText == "" {
                    Image("SearchMainImage")
                    
                } else {
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 10), GridItem(.flexible(), spacing: 10)], spacing: 10) {
                            ForEach(petViewModel.searchedPets, id: \.pet_id) { pet in
                                NavigationLink {
                                    AnimalDetailView(animalName: pet.name, animalBreeds: pet.breeds, animalAge:pet.age, isLike: pet.like)
                                } label: {
                                    AnimalFreeView(animalName: pet.name, animalAge: pet.age, animalSex: pet.sex, animalCenter: pet.center, isLike: pet.like)
                                        .clipShape(RoundedRectangle(cornerRadius: 14))
                                }
                            }
                        }
                        .padding([.top], -20)
                        .padding()
                        if petViewModel.searchedPets.isEmpty {
                            
                            Image("NoSearchResultImage")
                        }
                    }
                    .onChange(of: searchText) { oldValue, newValue in
                        petViewModel.findPets(searchKeyword: newValue)
                    }
                }
            }.onTapGesture {
                hideKeyboard()
            }
            Spacer()
            
        }
    }
}

#Preview {
    SearchView()
}
