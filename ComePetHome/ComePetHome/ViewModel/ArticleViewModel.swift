//
//  ArticleViewModel.swift
//  ComePetHome
//
//  Created by 주진형 on 1/12/24.
//

import Foundation

class ArticleViewModel: ObservableObject {
    @Published var articleList = [
        Article(aticleId: 1, writer: "홍길동", wirterImage: "", noticeTitle: "우리집 강아지를 소개합니다.", ArticleImages: ["Dog"], noticeContent: """
    저희 집 강아지 입니다!!!
    너무 예쁘죠?
    감사합니다.
    """, createdAt: Date(), likeNum: 3, articleOption: "temporaryProtection", comments: [Comment(commentWriter: "길동", commentImage: "", commentContent: "예쁘네여", commentDate: Date())]),
        Article(aticleId: 1, writer: "홍길동", wirterImage: "", noticeTitle: "우리집 강아지를 소개합니다.", ArticleImages: [""], noticeContent:
    """
    저희 집 강아지 입니다!!!
    너무 예쁘죠?
    감사합니다.
    """, createdAt: Date(), likeNum: 3, articleOption: "rearTimeReport", comments: [Comment(commentWriter: "길동", commentImage: "", commentContent: "예쁘네여", commentDate: Date())])]
    
    @Published var temporaryProtectArticle: [Article] = []
    @Published var realTimeReportArticle: [Article] = []
    @Published var lookingforArticle: [Article] = []
    @Published var adoptionReviewArticle: [Article] = []
    
    init() {
        categorizeArticles()
    }
    
    func categorizeArticles() {
        for article in articleList {
            switch article.articleOption {
            case "temporaryProtection":
                temporaryProtectArticle.append(article)
            case "rearTimeReport":
                realTimeReportArticle.append(article)
            case "lookinfor":
                lookingforArticle.append(article)
            case "adoptionReview":
                adoptionReviewArticle.append(article)
            default:
                break
            }
        }
    }
}

