//
//  MyPageView.swift
//  ComePetHome
//
//  Created by 주진형 on 12/26/23.
//

import SwiftUI

struct MyPageView: View {
    var isLogin = true
    @EnvironmentObject var userViewModel: UserViewModel
    var body: some View {
        VStack {
            if userViewModel.isLogin == true {
                LogInMyPageView()
            } else {
                LogOutMyPageView()
            }
        } .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image(uiImage: UIImage(named: "ComePetHomeLogo")!)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                       
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundStyle(Color.gray)
                    }
                }
            }
    }
}

#Preview {
    NavigationStack {
        MyPageView().environmentObject(UserViewModel())
    }
}
