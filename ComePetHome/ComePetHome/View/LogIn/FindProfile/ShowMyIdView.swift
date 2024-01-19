//
//  ShowMyId.swift
//  ComePetHome
//
//  Created by 주진형 on 1/10/24.
//

import SwiftUI

struct ShowMyIdView: View {
    @Binding var isFindIdReturn: Bool
    @Binding var isShowMyIdRetrun: Bool
    var body: some View {
        Spacer()
        Image(systemName: "checkmark")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: .screenWidth * 0.1)
            .foregroundStyle(Color("AccentColor"))
            .padding(.bottom, .screenWidth * 0.1)
        VStack {
            Text("홍길동 님의 아이디는")
            HStack {
                Text("abc123@abc.com")
                    .font(Font.TheJamsilExtraBold26)
                    .foregroundStyle(Color("AccentColor"))
                Text("입니다")
            }
        }
        .font(Font.TheJamsilMedium26)
        .padding(.bottom, .screenWidth * 0.45)
        
        Spacer()
        
        Button{
            isFindIdReturn = false
            isShowMyIdRetrun = false
        } label: {
            Text("로그인 하러 가기")
                .font(Font.TheJamsilMedium24)
                .foregroundStyle(Color.white)
                .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                .background(Color("AccentColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .padding(.bottom, .screenWidth * 0.2)
    }
}

#Preview {
    ShowMyIdView(isFindIdReturn: .constant(true), isShowMyIdRetrun: .constant(true))
}
