//
//  Notice.swift
//  ComePetHome
//
//  Created by 주진형 on 1/12/24.
//

import Foundation

struct Article: Codable {
    var writer: String
    var wirterImage: String
    var noticeTitle: String
    var ArticleImages: [String]
    var noticeContent: String
    var createdAt: Date
    var likeNum: Int
    var comment: [Comment]
}

struct Comment: Codable {
    var commentWriter: String
    var commentImage: String
    var commentContent: String
}


