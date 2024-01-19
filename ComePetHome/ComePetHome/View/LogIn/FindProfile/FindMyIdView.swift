//
//  FindMyId.swift
//  ComePetHome
//
//  Created by 주진형 on 1/10/24.
//

import SwiftUI

struct FindMyIdView: View {
    enum FocusableField: Hashable {
        case userName
        case userPhonenum
    }
    @EnvironmentObject var userViewModel: UserViewModel
    @FocusState var focusField: FocusableField?
    @State private var userName: String = ""
    @State private var userPhonenum: String = ""
    
    @State var isTouchedName = false
    @State var isTouchedPhonenum = false
    
    @Binding var isFindIdReturn: Bool
    @State var isShowMyIdRetrun: Bool = false
    @State var isFindingId: Bool = false
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
            Text("아이디를 확인하세요")
                .font(Font.TheJamsilMedium26)
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: 0))
            Text("이름")
                .font(Font.TheJamsilRegular16)
                .padding(EdgeInsets(top: 0, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.02, trailing: 0))
            HStack {
                TextField("이름을 입력해 주세요", text: self.$userName)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .focused($focusField, equals: .userName)
                if !userName.isEmpty {
                    Button(action: {
                        self.userName = ""
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
                    .stroke(isTouchedName ? Color("AccentColor") : Color.black, lineWidth: 1.5)
                    .frame(height: .screenWidth * 0.14, alignment: .center)
            }
            .frame(height: .screenWidth * 0.1415, alignment: .center)
            .background(Color("MainColor").opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.horizontal, .screenWidth * 0.1)
            .padding(.bottom, .screenWidth * 0.05)
            .font(.TheJamsilRegular18)
            
            Text("휴대폰 번호")
                .font(Font.TheJamsilRegular16)
                .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.02, trailing: 0))
            HStack {
                TextField("휴대폰 번호를 입력해 주세요", text: self.$userPhonenum)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .focused($focusField, equals: .userPhonenum)
                if !userPhonenum.isEmpty {
                    Button(action: {
                        self.userPhonenum = ""
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
                    .stroke(isTouchedPhonenum ? Color("AccentColor") : Color.black, lineWidth: 1.5)
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
            case .userName:
                isTouchedName = true
                isTouchedPhonenum = false
            case .userPhonenum:
                isTouchedName = false
                isTouchedPhonenum = true
            case .none:
                isTouchedName = false
                isTouchedPhonenum = false
            }
        }
        if isFindingId {
            ProgressView("동물들의 정보를 불러오는 중 입니다")
                .progressViewStyle(CircularProgressViewStyle())
        }
        Spacer()
        Button {
            userViewModel.findMyId(name: userName, phoneNumber: userPhonenum)
            if userViewModel.findId.isEmpty {
                isFindingId = true
            } else {
                isFindingId = false
                if userViewModel.findId == "유저가 존재하지 않습니다." {
                    print("!")
                    isFindingId = false
                } else {
                    isShowMyIdRetrun = true
                }
            }
        } label: {
            Text("아이디 찾기")
                .font(Font.TheJamsilMedium24)
                .foregroundStyle(Color.white)
                .frame(width: .screenWidth * 0.8, height: .screenWidth * 0.13)
                .background(!userName.isEmpty && !userPhonenum.isEmpty ? Color("AccentColor") : Color("DisableColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .disabled(!userName.isEmpty && !userPhonenum.isEmpty ? false : true)
        .navigationDestination(isPresented: $isShowMyIdRetrun) {
            ShowMyIdView(isFindIdReturn: $isFindIdReturn, isShowMyIdRetrun: $isShowMyIdRetrun)
        }
        .padding(.bottom, .screenWidth * 0.2)
        .onChange(of: userViewModel.findId.isEmpty) {
            isFindingId = false
        }
    }
        
}

#Preview {
    FindMyIdView(isFindIdReturn: .constant(true)).environmentObject(UserViewModel())
}
