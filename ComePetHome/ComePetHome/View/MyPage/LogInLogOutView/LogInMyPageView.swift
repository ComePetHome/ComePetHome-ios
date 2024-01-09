//
//  LogInMyPageView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct LogInMyPageView: View {
    var body: some View {
        NavigationStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: .screenWidth * 0.23)
                        .frame(width: .screenWidth * 0.23, height: .screenWidth * 0.23)
                        .foregroundStyle(Color("MainColor"))
                    Image("ComePetHomeLogoImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: .screenWidth * 0.2)
                }
                VStack(alignment: .leading) {
                    Text("홍길동")
                        .font(.TheJamsilRegular18)
                        .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.005, trailing: 0))
                    Text("Hong1234")
                        .font(.TheJamsilRegular14)
                        .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.005, trailing: 0))
                        .foregroundStyle(Color.black.opacity(0.5))
                }
                Spacer()
                
            }
            .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.5 - .screenWidth * 0.3, bottom: 0, trailing: 10))
            Rectangle()
                .frame(width: .screenWidth, height: 1)
                .foregroundStyle(Color("MainColor"))
                .padding(EdgeInsets(top: .screenWidth * 0.05, leading: 0, bottom: .screenWidth * 0.05, trailing: 0))
            VStack {
                NavigationLink {
                    EditMyInformaitionView()
                } label: {
                    HStack {
                        Text("내 정보 수정")
                            .font(.TheJamsilMedium24)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.TheJamsilMedium24)
                    }
                }
                .foregroundStyle(Color("FontBlackWhiteColor"))
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.05, bottom: .screenWidth * 0.1, trailing: 10))
                HStack {
                    NavigationLink {
                        LikeAnimalView()
                    } label: {
                        Text("관심동물")
                            .font(.TheJamsilMedium24)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.TheJamsilMedium24)
                    }
                }
                .foregroundStyle(Color("FontBlackWhiteColor"))
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.05, bottom: .screenWidth * 0.1, trailing: 10))
                HStack {
                    NavigationLink {
                        NoticeBoradWrite()
                    } label: {
                        Text("게시판 작성글/댓글")
                            .font(.TheJamsilMedium24)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.TheJamsilMedium24)
                    }
                }
                .foregroundStyle(Color("FontBlackWhiteColor"))
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.05, bottom: .screenWidth * 0.05, trailing: 10))
            }
            Spacer()
        }
    }
}

#Preview {
    LogInMyPageView()
}
