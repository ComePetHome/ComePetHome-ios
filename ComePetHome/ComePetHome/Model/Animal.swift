//
//  Animal.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import Foundation

struct Pet: Codable, Hashable {
    let pet_id: Int
    let name: String
    let center: String
    var enlistment_date: String
    let breeds: String
    let sex: String
    let age: String
    let adp_status: String
    let like: Bool
}

struct PetDetail: Codable {
    let pet_id: Int
    let name: String
    let center: String
    let enlistment_date: String
    let breeds: String
    let sex: String
    let age: String
    let adp_status: String
    let species: String
    let weight: Double
    let intro_url: String
    let intro_contents: String
    let thumbnail_url: String
    let created_at: String
    let updated_at: String
}
