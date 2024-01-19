//
//  LogOutMyPageView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct LogOutMyPageView: View {
    @State private var isSheet = false
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: .screenWidth * 0.23)
                    .frame(width: .screenWidth * 0.23, height: .screenWidth * 0.23)
                    .foregroundStyle(Color("MainColor"))
                Image("ComePetHomeLogoImage")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: .screenWidth * 0.2)
            }
            .padding([.bottom], .screenWidth * 0.05)
            Text("로그인 후 이용해 주세요")
                .font(.TheJamsilBold24)
                .padding([.bottom], .screenWidth * 0.1)
            Button {
                isSheet = true
                
            } label: {
                Text("로그인 하러 가기")
                    .font(.TheJamsilRegular16)
                    .foregroundStyle(Color("FontBlackWhiteColor").opacity(0.5))
                Image(systemName: "chevron.right")
                    .font(.TheJamsilRegular16)
                    .foregroundStyle(Color("FontBlackWhiteColor").opacity(0.5))
            }
            .sheet(isPresented: $isSheet) {
                LogInView(isSheet: $isSheet)
            }
        }
    }
}

#Preview {
    LogOutMyPageView()
}
