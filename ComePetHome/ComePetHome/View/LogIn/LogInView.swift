//
//  LogInView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct LogInView: View {
    enum FocusableField: Hashable {
        case userId
        case userPassword
    }
    @FocusState var focusField: FocusableField?
    @State var isReturn = false
    
    @State private var userId: String = ""
    @State private var userPassword: String = ""
    
    @State var isTouchedId = false
    @State var isTouchedPassword = false
    
    var body: some View {
        NavigationStack {
            Image("SignUpOne")
            VStack {
                HStack {
                    Text("컴펫홈")
                        .font(Font.TheJamsilExtraBold30)
                        .foregroundStyle(Color("AccentColor"))
                        .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
                    Spacer()
                }
                HStack {
                    TextField("아이디", text: self.$userId)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .focused($focusField, equals: .userId)
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
                
                HStack {
                    TextField("비밀번호", text: self.$userPassword)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .focused($focusField, equals: .userPassword)
                    if !userPassword.isEmpty {
                        Button(action: {
                            self.userPassword = ""
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
                        .stroke(isTouchedPassword ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                        .frame(height: .screenWidth * 0.14, alignment: .center)
                }
                .frame(height: .screenWidth * 0.1415, alignment: .center)
                .background(Color("MainColor").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, .screenWidth * 0.1)
                .padding(.bottom, .screenWidth * 0.05)
                .font(.TheJamsilRegular18)
            }
            .onChange(of: focusField) {
                switch focusField {
                case .userId:
                    isTouchedId = true
                    isTouchedPassword = false
                case .userPassword:
                    isTouchedId = false
                    isTouchedPassword = true
                case .none:
                    isTouchedId = false
                    isTouchedPassword = false
                }
            }
            Spacer()
            Button {
                
            } label: {
                Text("로그인")
                    .font(Font.TheJamsilMedium24)
                    .foregroundStyle(Color.white)
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                    .background(Color("AccentColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 10, trailing: 10))
            }
            HStack {
                Button {
                    
                } label: {
                    Text("아이디 찾기")
                        .font(Font.TheJamsilRegular14)
                        .foregroundStyle(Color("FontBlackWhiteColor"))
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                }
                
                Divider()
                    .frame(height: 20)
                
                Button {
                    
                } label: {
                    Text("비밀번호 찾기")
                        .font(Font.TheJamsilRegular14)
                        .foregroundStyle(Color("FontBlackWhiteColor"))
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                }
                
                Divider()
                    .frame(height: 20)
                
                Button {
                    isReturn = true
                } label: {
                    Text("회원가입")
                        .font(Font.TheJamsilRegular14)
                        .foregroundStyle(Color("FontBlackWhiteColor"))
                        .padding(EdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5))
                }
                .navigationDestination(isPresented: $isReturn) {
                    SignUpIdView(isReturn: $isReturn)
                }
            }
            .padding(.bottom, .screenHeight * 0.1)
        }
    }
}

#Preview {
    LogInView()
}
