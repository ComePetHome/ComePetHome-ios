//
//  NoticeView.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import SwiftUI

struct NoticeView: View {
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @State private var selectedNumber: Int = 0
    var body: some View {
        NavigationStack {
            HStack {
                Button {
                    selectedNumber = 0
                } label: {
                    Text("임시보호")
                        .font(.TheJamsilExtraBold14)
                        .foregroundStyle(colorScheme == .light ? (selectedNumber == 0 ? Color("AccentColor") : Color.gray) : (selectedNumber == 0 ? Color.white : Color.white.opacity(0.5)))
                        .frame(width: .screenWidth * 0.21, height: .screenWidth * 0.08)
                        .background(Color("MainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button {
                    selectedNumber = 1
                } label: {
                    Text("실시간 제보")
                        .font(.TheJamsilExtraBold14)
                        .foregroundStyle(colorScheme == .light ? (selectedNumber == 1 ? Color("AccentColor") : Color.gray) : (selectedNumber == 1 ? Color.white : Color.white.opacity(0.5)))
                        .frame(width: .screenWidth * 0.21, height: .screenWidth * 0.08)
                        .background(Color("MainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button {
                    selectedNumber = 2
                } label: {
                    Text("찾습니다")
                        .font(.TheJamsilExtraBold14)
                        .foregroundStyle(colorScheme == .light ? (selectedNumber == 2 ? Color("AccentColor") : Color.gray) : (selectedNumber == 2 ? Color.white : Color.white.opacity(0.5)))
                        .frame(width: .screenWidth * 0.21, height: .screenWidth * 0.08)
                        .background(Color("MainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                Button {
                    selectedNumber = 3
                } label: {
                    Text("입양후기")
                        .font(.TheJamsilExtraBold14)
                        .foregroundStyle(colorScheme == .light ? (selectedNumber == 3 ? Color("AccentColor") : Color.gray) : (selectedNumber == 3 ? Color.white : Color.white.opacity(0.5)))
                        .frame(width: .screenWidth * 0.21, height: .screenWidth * 0.08)
                        .background(Color("MainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding([.top], 10)
            Spacer()
            switch selectedNumber {
            case 0:
                TemporaryProtectionView()
            case 1:
                RealTimeReportingView()
            case 2:
                LookingforView()
            case 3:
                AdoptionReviewView()
            default:
                Image("NoNoticeImage")
            }
            Spacer()
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image(uiImage: UIImage(named: "CommunityLogo")!)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            
                        } label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(Color.gray)
                        }
                    }
                }
        }
    }
}

#Preview {
    NavigationStack {
        NoticeView()
    }
}
