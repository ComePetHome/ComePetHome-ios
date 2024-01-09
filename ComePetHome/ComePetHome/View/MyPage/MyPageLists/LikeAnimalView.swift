//
//  LikeAnimalView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct LikeAnimalView: View {
    var body: some View {
        NavigationStack {
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("관심동물")
                    .font(Font.TheJamsilMedium16)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LikeAnimalView()
    }
}
