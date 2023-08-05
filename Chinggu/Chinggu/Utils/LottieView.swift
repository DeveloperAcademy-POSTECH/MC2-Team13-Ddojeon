//
//  LottieView.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/04/18.
//

import Lottie
import SwiftUI

struct LottieView : UIViewRepresentable {
	var filename: String
	var loopState: Bool
	var contentMode: UIView.ContentMode = .scaleAspectFit
	
	@Binding var playState: Bool
	
	
	func makeUIView(context: Context) -> Lottie.LottieAnimationView {
		let view = UIView(frame: .zero)
		let animationView = LottieAnimationView()
		
		animationView.animation = LottieAnimation.named(filename)
		animationView.contentMode = contentMode
		if loopState {
			animationView.loopMode = .loop
		}
		
		
		animationView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(animationView)
		
		NSLayoutConstraint.activate([
			animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
			animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
		])
		
		return animationView
	}
	
	func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
		if playState {
			uiView.play()
		}
	}
}



