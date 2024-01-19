//
//  SignUpPasswordView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct SignUpPasswordView: View {
    enum FocusableField: Hashable {
        case userPassword
        case userPasswordConfirm
    }
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState var focusField: FocusableField?
    @Binding var isReturn: Bool
    
    @State private var userPassword: String = ""
    @State private var userPasswordConfirm: String = ""
    
    @State var isToucheduserPassword = false
    @State var isToucheduserPasswordConfirm = false
    @State var isShowPassword = false
    @State var isShowPasswordConfirm = false
    var body: some View {
        VStack {
            Image("SignUpThree")
            VStack(alignment: .leading) {
                Text("비밀번호를 입력해 주세요")
                    .font(Font.TheJamsilMedium20)
                    .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
                HStack {
                    if isShowPassword {
                        TextField("비밀번호", text: self.$userPassword)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .focused($focusField, equals: .userPassword)
                    } else {
                        SecureField("비밀번호", text: self.$userPassword)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .focused($focusField, equals: .userPassword)
                    }
                    Button(action: {
                        isShowPassword.toggle()
                    }) {
                        Image(systemName: isShowPassword ?  "eye.slash" : "eye")
                    }
                    .padding(.trailing, 5)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isToucheduserPassword ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                        .frame(height: .screenWidth * 0.14, alignment: .center)
                }
                .frame(height: .screenWidth * 0.1415, alignment: .center)
                .background(Color("MainColor").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, .screenWidth * 0.1)
                .padding(.bottom, .screenWidth * 0.05)
                .font(.TheJamsilRegular18)
                HStack {
                    if isShowPasswordConfirm {
                        TextField("비밀번호 확인", text: self.$userPasswordConfirm)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .focused($focusField, equals: .userPasswordConfirm)
                    } else {
                        SecureField("비밀번호 확인", text: self.$userPasswordConfirm)
                            .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                            .focused($focusField, equals: .userPasswordConfirm)
                    }
                    Button(action: {
                        isShowPasswordConfirm.toggle()
                    }) {
                        Image(systemName: isShowPasswordConfirm ?  "eye.slash" : "eye")
                    }
                    .padding(.trailing, 5)
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isToucheduserPasswordConfirm ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                        .frame(height: .screenWidth * 0.14, alignment: .center)
                }
                .frame(height: .screenWidth * 0.1415, alignment: .center)
                .background(Color("MainColor").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, .screenWidth * 0.1)
                .padding(.bottom, 0)
                .font(.TheJamsilRegular18)
                
                Text("비밀번호가 일치하지 않습니다")
                    .font(Font.TheJamsilRegular18)
                    .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
                    .foregroundStyle(userPassword == userPasswordConfirm || userPasswordConfirm.isEmpty ? Color.clear : Color.red)
                
            }.onChange(of: focusField) {
                switch focusField {
                case .userPassword:
                    isToucheduserPassword = true
                    isToucheduserPasswordConfirm = false
                case .userPasswordConfirm:
                    isToucheduserPassword = false
                    isToucheduserPasswordConfirm = true
                case .none:
                    isToucheduserPassword = false
                    isToucheduserPasswordConfirm = false
                }
            }
            Spacer()
            NavigationLink {
                SignUpNicknameView(isReturn: $isReturn)
            } label: {
                Text("다음")
                    .font(Font.TheJamsilMedium24)
                    .foregroundStyle(Color.white)
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                    .background(!userPassword.isEmpty && !userPasswordConfirm.isEmpty && userPassword == userPasswordConfirm ? Color("AccentColor") : Color("DisableColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .disabled(!userPassword.isEmpty && !userPasswordConfirm.isEmpty && userPassword == userPasswordConfirm ? false : true)
            .padding(.bottom, 30)
        }
        .onDisappear{
            userViewModel.user.password = userPassword
        }
    }
}

#Preview {
    SignUpPasswordView(isReturn: .constant(true)).environmentObject(UserViewModel())
}
