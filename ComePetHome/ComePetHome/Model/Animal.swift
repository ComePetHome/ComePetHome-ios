//
//  Animal.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import Foundation

struct Animal {
    let animalID: Int
    let animalName: String
    let enlistmentDate: Date
    let species: String
    let age: Int
    let weight: Double
    let adpStatus: String
    let temporaryProtectionStatus: String
    let introURL: String
    let introContents: String
    let temporaryProtectionContents: String
    let thumbnailURL: String
    let createdAt: Date
    let updatedAt: Date
}

struct Pet: Codable {
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
