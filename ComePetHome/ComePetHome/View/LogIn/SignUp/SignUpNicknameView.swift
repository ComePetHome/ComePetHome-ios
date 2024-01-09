//
//  SignUpNicknameView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct SignUpNicknameView: View {
    
    enum FocusableField: Hashable {
        case userNickname
    }
    @FocusState var focusField: FocusableField?
    @Binding var isReturn: Bool
    @State private var userNickname: String = ""
    @State var isTouchedNickname = false
    var body: some View {
        Image("SignUpFour")
        VStack(alignment: .leading) {
            Text("닉네임을 입력해 주세요")
                .font(Font.TheJamsilMedium20)
                .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
            HStack {
                TextField("닉네임", text: self.$userNickname)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .focused($focusField, equals: .userNickname)
                if !userNickname.isEmpty {
                    Button(action: {
                        self.userNickname = ""
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
                    .stroke(isTouchedNickname ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                    .frame(height: .screenWidth * 0.14, alignment: .center)
            }
            .frame(height: .screenWidth * 0.1415, alignment: .center)
            .background(Color("MainColor").opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, .screenWidth * 0.1)
            .padding(.bottom, .screenWidth * 0.05)
            .font(.TheJamsilRegular18)
        }.onChange(of: focusField) {
            switch focusField {
            case .userNickname:
                isTouchedNickname = true
            case .none:
                isTouchedNickname = false
            }
        }
        Spacer()
        NavigationLink {
            SignUpNameView(isReturn: $isReturn)
        } label: {
            Text("다음")
                .font(Font.TheJamsilMedium24)
                .foregroundStyle(Color.white)
                .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                .background(userNickname.isEmpty ? Color("DisableColor") : Color("AccentColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .disabled(userNickname.isEmpty ? true : false)
        .padding(.bottom, 30)
    }
}

#Preview {
    SignUpNicknameView(isReturn: .constant(true))
}
