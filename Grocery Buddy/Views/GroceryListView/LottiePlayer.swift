//
//  LottiePlayer.swift
//  Grocery Buddy
//
//  Created by Michael Sebsbe on 2023-10-10.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationView = LottieAnimationView()
    var filename = "Loading"
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        
        let animation = LottieAnimation.named(filename)
        
        animationView.animation = animation
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        animationView.play()
    }
}
