//
//  SignUpIdView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct SignUpIdView: View {
    enum FocusableField: Hashable {
        case userId
    }
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState var focusField: FocusableField?
    @Binding var isReturn: Bool
    
    @State private var userId: String = ""
    
    @State var isTouchedId = false
    @State var tag:Int? = nil
    var body: some View {
        VStack {
            Image("SignUpTwo")
            VStack(alignment: .leading) {
                Text("아이디를 입력해 주세요")
                    .font(Font.TheJamsilMedium20)
                    .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
                HStack {
                    TextField("아이디", text: self.$userId)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .focused($focusField, equals: .userId)
                        .onSubmit {
                            userViewModel.user.userId = userId
                        }
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
            }.onChange(of: focusField) {
                switch focusField {
                case .userId:
                    isTouchedId = true
                    userViewModel.user.userId = userId
                case .none:
                    isTouchedId = false
                }
            }
            Spacer()
            NavigationLink {
                SignUpPasswordView(isReturn: $isReturn)
            } label: {
                Text("다음")
                    .font(Font.TheJamsilMedium24)
                    .foregroundStyle(Color.white)
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                    .background(userId.isEmpty ? Color("DisableColor") : Color("AccentColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .disabled(userId.isEmpty ? true : false)
            .padding(.bottom, 30)
            
        }
        .onDisappear{
            userViewModel.user.userId = userId
        }
    }
}

#Preview {
    SignUpIdView(isReturn: .constant(true)).environmentObject(UserViewModel())
}
