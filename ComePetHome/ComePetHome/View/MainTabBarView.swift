//
//  MainTabBarView.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import SwiftUI

struct MainTabBarView: View {
    @State private var selection = 0 // 탭 선택을 추적하기 위한 상태 변수
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var petViewModel = PetViewModel()
    var body: some View {
        TabView(selection: $selection) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                    Text("홈")
                }
                .tag(0)
                .environmentObject(petViewModel)
            NoticeView()
                .tabItem {
                    Image(systemName: "person.3.sequence")
                    Text("게시판")
                }
                .tag(1)
            
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("동물 조회")
                }
                .tag(2)
            
            MyPageView()
                .tabItem {
                    Image(systemName: "person")
                    Text("마이")
                }
                .tag(4)
                .environmentObject(userViewModel)
           
        }
    }
}

#Preview {
    MainTabBarView()//.environmentObject(UserViewModel())
}
