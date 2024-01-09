//
//  EditMyInformaitionView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct EditMyInformaitionView: View {
    enum FocusableField: Hashable {
        case userNickName
        case userId
        case userPhoneNum
    }
    @State private var userNickName: String = "홍길동"  // 사용자 아이디
    @State private var userId: String = "hong1234"
    @State private var userPhoneNum: String = "010-1234-5678"
    @State var isTouchedNickName = false
    @State var isTouchedId = false
    @State var isTouchedPhoneNum = false
    
    @FocusState var focusField: FocusableField?
    
    var body: some View {
        VStack {
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: .screenWidth * 0.23)
                        .frame(width: .screenWidth * 0.23, height: .screenWidth * 0.23)
                        .foregroundStyle(Color("MainColor"))
                    Image("ComePetHomeLogoImage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: .screenWidth * 0.2)
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundStyle(Color("AccentColor"))
                        .frame(width: .screenWidth * 0.08)
                        .offset(x: 35, y: 35)
                }
            }
            VStack(alignment:.leading) {
                Text("닉네임")
                    .font(.TheJamsilRegular16)
                    .padding([.horizontal], .screenWidth * 0.1)
                    .padding(.bottom, .screenWidth * 0.01)
                HStack {
                    TextField(userNickName, text: self.$userNickName, prompt:Text(userNickName).foregroundStyle(Color.black))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .focused($focusField, equals: .userNickName)
                    if !userNickName.isEmpty {
                        Button(action: {
                            self.userNickName = ""
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
                        .stroke(isTouchedNickName ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                        .frame(height: .screenWidth * 0.14, alignment: .center)
                }
                .frame(height: .screenWidth * 0.1415, alignment: .center)
                .background(Color("MainColor").opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal, .screenWidth * 0.1)
                .padding(.bottom, .screenWidth * 0.05)
                .font(.TheJamsilRegular18)
                
                Text("아이디")
                    .font(.TheJamsilRegular16)
                    .padding([.horizontal], .screenWidth * 0.1)
                    .padding(.bottom, .screenWidth * 0.01)
                HStack {
                    TextField(userId, text: self.$userId, prompt:Text(userId).foregroundStyle(Color.black))
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
                
                
                Text("휴대폰 번호")
                    .font(.TheJamsilRegular16)
                    .padding([.horizontal], .screenWidth * 0.1)
                    .padding(.bottom, .screenWidth * 0.01)
                HStack {
                    TextField(userPhoneNum, text: self.$userPhoneNum, prompt:Text(userPhoneNum).foregroundStyle(Color.black))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .focused($focusField, equals: .userPhoneNum)
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
                //.padding(.bottom, .screenWidth * 0.05)
                .font(.TheJamsilRegular18)
                
            }
            .onChange(of: focusField) {
                switch focusField {
                case .userNickName:
                    isTouchedNickName = true
                    isTouchedId = false
                    isTouchedPhoneNum = false
                case .userId:
                    isTouchedNickName = false
                    isTouchedId = true
                    isTouchedPhoneNum = false
                case .userPhoneNum:
                    isTouchedNickName = false
                    isTouchedId = false
                    isTouchedPhoneNum = true
                case .none:
                    isTouchedNickName = false
                    isTouchedId = false
                    isTouchedPhoneNum = false
                }
            }
            Spacer()
            Button {
                
            } label: {
                Text("수정하기")
                    .font(Font.TheJamsilMedium24)
                    .foregroundStyle(Color.white)
                    .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                    .background(Color("AccentColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    
            }
            .padding(.top, 80)
            HStack {
                Button {
                    
                } label: {
                    Text("로그아웃")
                        .foregroundStyle(Color.gray)
                        .font(Font.TheJamsilRegular12)
                }
                Divider()
                    .frame(height: 20)
                Button {
                    
                } label: {
                    Text("회원탈퇴")
                        .foregroundStyle(Color.gray)
                        .font(Font.TheJamsilRegular12)
                }
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // <-
            .onTapGesture {
                hideKeyboard()
                isTouchedNickName = false
                isTouchedId = false
                isTouchedPhoneNum = false
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("내 정보 수정")
                        .font(Font.TheJamsilMedium16)
                }
            }
    }
}

#Preview {
    NavigationStack {
        EditMyInformaitionView()
    }
}
