//
//  RecipeWebView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2/21/23.
//

import SwiftUI
import WebKit

struct RecipeWebView: UIViewRepresentable{
    var url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
