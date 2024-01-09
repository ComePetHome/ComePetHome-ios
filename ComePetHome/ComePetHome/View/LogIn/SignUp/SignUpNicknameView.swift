//
//  SignUpNicknameView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    @Binding var isReturn: Bool
    var body: some View {
        Image("SignUpFour")
        Text("닉네임을 입력하세요")
        NavigationLink {
            SignUpNameView(isReturn: $isReturn)
        } label: {
            Text("다음")
                .font(Font.TheJamsilMedium24)
                .foregroundStyle(Color.white)
                .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                .background(Color("AccentColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
    }
}

#Preview {
    SignUpNicknameView(isReturn: .constant(true))
}
