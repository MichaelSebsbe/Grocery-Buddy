//
//  RecipeWebView.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2/21/23.
//

import SwiftUI
import SafariServices

struct RecipeWebView: UIViewControllerRepresentable {
    typealias UIViewControllerType = SFSafariViewController
    
    var url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.preferredControlTintColor = UIColor(.green)
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
