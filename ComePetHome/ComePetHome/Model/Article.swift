//
//  Notice.swift
//  ComePetHome
//
//  Created by 주진형 on 1/12/24.
//

import Foundation
import SwiftUI

struct Article: Codable {
    var aticleId: Int
    var writer: String
    var wirterImage: String
    var articleTitle: String
    var ArticleImages: [String]
    var articleContent: String
    var createdAt: Date
    var likeNum: Int
    var articleOption: String
    var comments: [Comment]
}

struct Comment: Codable {
    var commentWriter: String
    var commentImage: String
    var commentContent: String
    var commentDate: Date
}

enum ArticleOption: String, CaseIterable {
    case temporaryProtection = "임시보호"
    case realTiemReport = "실시간 제보"
    case lookingfor = "찾습니다"
    case adoptionReview = "입양후기"
    
    //var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
