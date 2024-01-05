//
//  AnimalYoutubeWebView.swift
//  ComePetHome
//
//  Created by 주진형 on 1/4/24.
//

import SwiftUI
import WebKit

struct AnimalYoutubeWebView: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}
#Preview {
    AnimalYoutubeWebView(urlString: "https://www.youtube.com/watch?v=MDvcp-gOwYQ&t=36s")
}
