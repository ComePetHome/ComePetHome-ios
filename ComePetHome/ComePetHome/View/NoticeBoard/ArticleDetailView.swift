//
//  ArticleDetailView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/12/24.
//

import SwiftUI

struct ArticleDetailView: View {
    var article: Article
    @State var comment: String = ""
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    if article.wirterImage.isEmpty {
                        ZStack {
                            RoundedRectangle(cornerRadius: .screenWidth * 0.15)
                                .frame(width: .screenWidth * 0.15, height: .screenWidth * 0.15)
                                .foregroundStyle(Color("MainColor"))
                            Image("ComePetHomeLogoImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: .screenWidth * 0.15)
                        }
                    }else {
                        //프로필 사진
                    }
                    VStack {
                        Text(article.writer)
                            .font(.TheJamsilRegular16)
                            .padding(.bottom, 2)
                        Text("1시간전")
                            .font(.TheJamsilRegular12)
                            .foregroundStyle(Color.black.opacity(0.5))
                    }
                    Spacer()
                }
                HStack {
                    VStack(alignment: .leading) {
                        Text(article.noticeTitle)
                            .font(.TheJamsilBold20)
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                        Text(article.noticeContent)
                            .font(.TheJamsilRegular16)
                            
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 25)
            .padding(.bottom, 20)
            Image(article.ArticleImages[0])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: .screenWidth)
                .padding(.bottom, 10)
            
            HStack {
                Image(systemName: "heart.fill")
                    .font(Font.TheJamsilLight16)
                    .foregroundStyle(Color.red)
                Text("\(article.likeNum)")
                    .foregroundStyle(Color("FontBlackWhiteColor"))
                    .font(Font.TheJamsilLight16)
                    .padding(.leading, -5)
                    .padding(.trailing, 5)
                Image(systemName: "message")
                    .font(Font.TheJamsilLight16)
                    .foregroundStyle(Color("FontBlackWhiteColor"))
                Text("\(article.comments.count)")
                    .foregroundStyle(Color("FontBlackWhiteColor"))
                    .font(Font.TheJamsilLight16)
                    .padding(.leading, -5)
                Spacer()
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 5)
            Rectangle()
                .frame(width: .screenWidth)
                .foregroundStyle(Color("DisableColor"))
                .padding(.bottom, 5)
            
            ForEach(article.comments, id: \.commentDate) { comment in
                HStack {
                    if comment.commentImage.isEmpty {
                        ZStack {
                            RoundedRectangle(cornerRadius: .screenWidth * 0.1)
                                .frame(width: .screenWidth * 0.1, height: .screenWidth * 0.1)
                                .foregroundStyle(Color("MainColor"))
                            Image("ComePetHomeLogoImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: .screenWidth * 0.1)
                        }
                    }else {
                        //댓글 작성자 프로필 사진
                    }
                    Text(comment.commentWriter)
                        .font(.TheJamsilRegular16)
                    Spacer()
                }
                .padding(.horizontal, 30)
                HStack {
                    VStack(alignment: .leading) {
                        Text(comment.commentContent)
                            .font(.TheJamsilRegular16)
                        Text("1시간전")
                            .font(.TheJamsilRegular12)
                            .foregroundStyle(Color("FontBlackWhiteColor").opacity(0.5))
                    }
                    Spacer()
                }
                //.padding(.top, 5)
                .padding(.horizontal, 40)
            }
        }
        HStack {
            HStack {
                TextField("댓글을 입력해 주세요", text: $comment)
                    .foregroundColor(.primary)

                if !comment.isEmpty {
                    Button(action: {
                        //댓글 작성 함수
                    }) {
                        Image(systemName: "paperplane")
                            .foregroundStyle(Color("AccentColor"))
                    }
                } else {
                    EmptyView()
                }
            }
            .padding(EdgeInsets(top: 15, leading: 8, bottom: 15, trailing: 8))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
        }
        .padding(.horizontal)
        
    }
        
    
}

#Preview {
    ArticleDetailView(article: Article(aticleId: 1, writer: "홍길동", wirterImage: "", noticeTitle: "우리집 강아지를 소개합니다.", ArticleImages: ["Dog"], noticeContent: """
    저희 집 강아지 입니다!!!
    너무 예쁘죠?
    감사합니다.
    """, createdAt: Date(), likeNum: 3, articleOption: "temporaryProtection", comments: [Comment(commentWriter: "길동", commentImage: "", commentContent: "예쁘네여", commentDate: Date())]))
}
