//
//  FindMyPassword.swift
//  ComePetHome
//
//  Created by 주진형 on 1/10/24.
//

import SwiftUI

struct FindMyPasswordView: View {
    @FocusState private var isTouchedId: Bool
    @Binding var isFindMyPasswordReturn: Bool
    @State var isShowMyPasswordReturn: Bool = false
    @State private var userId: String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("컴팻홈")
                    .font(Font.TheJamsilExtraBold30)
                    .foregroundStyle(Color("AccentColor"))
                    .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: 0, trailing: 0))
                Text("가입 정보로")
                    .font(Font.TheJamsilMedium26)
                    .padding(EdgeInsets(top: .screenWidth * 0.05, leading: 0, bottom: 0, trailing: 0))
            }
            Text("비밀번호를 확인하세요")
                .font(Font.TheJamsilMedium26)
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: 0))
            Text("비밀번호를 찾으려는 아이디")
                .font(Font.TheJamsilRegular16)
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.02, trailing: 0))
            HStack {
                TextField("아이디를 입력해 주세요", text: self.$userId)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .focused($isTouchedId)
                if !userId.isEmpty {
                    Button(action: {
                        self.userId = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .padding(.trailing, 5)
                } else {
                    EmptyView()
                }
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isTouchedId ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                    .frame(height: .screenWidth * 0.14, alignment: .center)
            }
            .frame(height: .screenWidth * 0.1415, alignment: .center)
            .background(Color("MainColor").opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, .screenWidth * 0.1)
            .padding(.bottom, .screenWidth * 0.05)
            .font(.TheJamsilRegular18)
        }
        Spacer()
        Button {
            isShowMyPasswordReturn = true
        } label: {
            Text("비밀번호 찾기")
                .font(Font.TheJamsilMedium24)
                .foregroundStyle(Color.white)
                .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                .background(!userId.isEmpty ? Color("AccentColor") : Color("DisableColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .disabled(!userId.isEmpty ? false : true)
        .navigationDestination(isPresented: $isShowMyPasswordReturn) {
            ShowMyPasswordView(isFindMyPasswordReturn: $isFindMyPasswordReturn, isShowMyPasswordReturn: $isShowMyPasswordReturn)
        }
        .padding(.bottom, .screenWidth * 0.2)
    }
    
}

#Preview {
    FindMyPasswordView(isFindMyPasswordReturn: .constant(true))
}
