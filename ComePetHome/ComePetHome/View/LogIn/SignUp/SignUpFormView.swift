//
//  SignUpFormView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/9/24.
//

import SwiftUI

struct SignUpFormView: View {
    enum FocusableField: Hashable {
        case userId
    }
    @FocusState var focusField: FocusableField?
    @State private var userId: String = ""
    @State var isTouchedId = false
    var formString: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(formString) 입력해 주세요")
                .font(Font.TheJamsilMedium20)
                .padding(EdgeInsets(top: .screenWidth * 0.05, leading: .screenWidth * 0.1, bottom: .screenWidth * 0.05, trailing: .screenWidth * 0.1))
            HStack {
                TextField("\(String(formString.prefix(formString.count - 1)))", text: self.$userId)
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
        }.onChange(of: focusField) {
            switch focusField {
            case .userId:
                isTouchedId = true
            case .none:
                isTouchedId = false
            }
            
        }
    }
}

#Preview {
    SignUpFormView(formString: "이름을")
}
