//
//  AnimalFreeView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/3/24.
//

import SwiftUI

struct AnimalFreeView: View {
    var animalName: String
    var animalAge: String
    var animalSex: String
    var animalCenter: String
    var isLike: Bool
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color("MainColor"))
            VStack {
                ZStack {
                    Image("Dog")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    VStack {
                        Button(action: {}, label: {
                            ZStack {
                                Circle()
                                    .foregroundStyle(.white)
                                    .foregroundStyle(.opacity(80))
                                    .frame(width: 30,height: 30)
                                Image(systemName: isLike ? "heart.fill" : "heart")
                            }
                        })
                        .padding(.init(top: -75, leading: -83, bottom: 0, trailing: 0))
                        
                    }
                }
                Spacer()
                Text("\(animalName)")
                    .font(.TheJamsilRegular14)
                    .foregroundStyle(Color("FontBlackWhiteColor"))
                    .multilineTextAlignment(.leading)
                if animalSex == "M" {
                    Text("\(animalAge.replacingOccurrences(of: "[()]", with: "", options: .regularExpression))/수컷")
                        .font(.TheJamsilRegular14)
                        .foregroundStyle(Color("FontBlackWhiteColor"))
                        .multilineTextAlignment(.leading)
                } else {
                    Text("\(animalAge.replacingOccurrences(of: "[()]", with: "", options: .regularExpression))/암컷")
                        .font(.TheJamsilRegular14)
                        .foregroundStyle(Color("FontBlackWhiteColor"))
                        .multilineTextAlignment(.leading)
                }
                Text("\(animalCenter)")
                    .font(.TheJamsilRegular14)
                    .foregroundStyle(Color("FontBlackWhiteColor"))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
        }
        .frame(width: .screenWidth * 0.45, height: .screenWidth * 0.6)
        
    }
}

#Preview {
    AnimalFreeView(animalName: "칼리", animalAge: "1(세) 1(개월)", animalSex: "M", animalCenter: "마포센터", isLike: true)
}
