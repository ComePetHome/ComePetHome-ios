//
//  NoticeBoradWrite.swift
//  ComePetHome
//
//  Created by 주진형 on 1/8/24.
//

import SwiftUI

struct NoticeBoradWrite: View {
    var body: some View {
        NavigationStack {
            
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("게시판 작성글/댓글")
                    .font(Font.TheJamsilMedium16)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoticeBoradWrite()
    }
}
