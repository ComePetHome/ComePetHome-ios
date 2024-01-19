//
//  TemporaryProtectionView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/5/24.
//

import SwiftUI

struct ArticleListView: View {
    let articleList: [Article]
    let articleOption: String
    var body: some View {
        if articleList.isEmpty {
            Image("NoNoticeBoardImage")
        } else {
            ScrollView(.vertical, showsIndicators: true) {
                ForEach(articleList, id: \.aticleId) { article in
                    Divider()
                    NavigationLink {
                        ArticleDetailView(article: article)
                            .toolbar(.hidden, for: .tabBar)
                    } label: {
                        VStack{
                            HStack {
                                Text(articleOption)
                                    .font(Font.TheJamsilMedium12)
                                    .frame(width: .screenWidth * 0.15, height: .screenWidth * 0.05)
                                    .padding(EdgeInsets(top: 2, leading: 8, bottom: 2, trailing: 8))
                                    .background(Color("AccentColor"))
                                    .foregroundStyle(Color.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                Spacer()
                            }
                            HStack {
                                if article.wirterImage.isEmpty {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: .screenWidth * 0.1)
                                            .frame(width: .screenWidth * 0.1, height: .screenWidth * 0.1)
                                            .foregroundStyle(Color("MainColor"))
                                        Image("ComePetHomeLogoImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: .screenWidth * 0.1)
                                    }
                                }
                                VStack(alignment: .leading){
                                    Text(article.writer)
                                        .font(Font.TheJamsilRegular12)
                                        .foregroundStyle(Color("FontBlackWhiteColor"))
                                    Text("1시간전")
                                        .font(Font.TheJamsilRegular8)
                                        .foregroundStyle(Color("FontBlackWhiteColor").opacity(0.5))
                                }
                                Spacer()
                            }
                            .padding(.top, .screenWidth * 0.01)
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(article.noticeTitle)
                                        .font(Font.TheJamsilMedium16)
                                        .foregroundStyle(Color("FontBlackWhiteColor"))
                                        .padding([.top, .bottom],6)
                                    Text(article.noticeContent)
                                        .lineLimit(1)
                                        .foregroundStyle(Color("FontBlackWhiteColor"))
                                        .font(Font.TheJamsilLight12)
                                        .padding(.bottom, 14)
                                    HStack {
                                        Image(systemName: "heart.fill")
                                            .font(Font.TheJamsilLight14)
                                            .foregroundStyle(Color.red)
                                        Text("\(article.likeNum)")
                                            .foregroundStyle(Color("FontBlackWhiteColor"))
                                            .font(Font.TheJamsilLight12)
                                            .padding(.leading, -5)
                                            .padding(.trailing, 5)
                                        Image(systemName: "message")
                                            .font(Font.TheJamsilLight14)
                                            .foregroundStyle(Color("FontBlackWhiteColor"))
                                        Text("\(article.comments.count)")
                                            .foregroundStyle(Color("FontBlackWhiteColor"))
                                            .font(Font.TheJamsilLight12)
                                            .padding(.leading, -5)
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ArticleListView(articleList: [Article(aticleId: 1, writer: "홍길동", wirterImage: "", noticeTitle: "우리집 강아지를 소개합니다.", ArticleImages: [""], noticeContent: """
    저희 집 강아지 입니다!!!
    너무 예쁘죠?
    감사합니다.
    """, createdAt: Date(), likeNum: 3, articleOption: "temporaryProtection", comments: [Comment(commentWriter: "길동", commentImage: "", commentContent: "예쁘네여", commentDate: Date())])], articleOption: "임시보호")
}
