//
//  SignUpPhonenumView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct SignUpPhonenumView: View {
    enum FocusableField: Hashable {
        case userPhoneNum
    }
    @FocusState var focusField: FocusableField?
    @EnvironmentObject var userViewModel: UserViewModel
    @Binding var isReturn: Bool
    @State private var userPhoneNum: String = ""
    
    @State var isTouchedPhoneNum = false
    var body: some View {
        Image("SignUpFinish")
        VStack {
            VStack(alignment: .leading) {
                Text("휴대폰 번호를 입력해 주세요")
                    .font(Font.TheJamsilMedium20)
                    .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
                HStack {
                    TextField("휴대폰 번호", text: self.$userPhoneNum)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .focused($focusField, equals: .userPhoneNum)
                        .keyboardType(.decimalPad)
                    if !userPhoneNum.isEmpty {
                        Button(action: {
                            self.userPhoneNum = ""
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
                        .stroke(isTouchedPhoneNum ? Color("AccentColor") : Color.black, lineWidth: 1.5)
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
                case .userPhoneNum:
                    isTouchedPhoneNum = true
                case .none:
                    isTouchedPhoneNum = false
                }
            }
            Spacer()
            Button {
                userViewModel.user.phoneNumber = userPhoneNum
                print(userViewModel.user)
                userViewModel.postSignUp(user: userViewModel.user)
                isReturn = false
            } label: {
                Text("완료")
                    .font(Font.TheJamsilMedium24)
                    .foregroundStyle(Color.white)
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                    .background(userPhoneNum.isEmpty ? Color("DisableColor") : Color("AccentColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .disabled(userPhoneNum.isEmpty ? true : false)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-
            .onTapGesture {
                hideKeyboard()
                isTouchedPhoneNum = false
            }
           
    }
}
#Preview {
    SignUpPhonenumView(isReturn: .constant(true)).environmentObject(UserViewModel())
}
