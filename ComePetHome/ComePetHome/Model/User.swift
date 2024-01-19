//
//  User.swift
//  ComePetHome
//
//  Created by 주진형 on 1/10/24.
//

import Foundation

struct User: Codable {
    var userId: String
    var password: String
    var nickName: String
    //var imageUrl: String
    var name: String
    var phoneNumber: String
}

struct Login: Codable {
    var userId: String
    var password: String
}

struct SavedUser: Codable {
    var userId: String
    var nickName: String
    var imageUrl: String
    var name: String
    var phoneNumber: String
}
