//
//  CardView.swift
//  mc2Test
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardView: View {
	
	@Namespace var namespace
	@State var show = false
	
	var body: some View {
		ZStack {
			Color.black.opacity(0.5).ignoresSafeArea()
			if !show {
				CardPopupView(namespace: namespace, show: $show)
			} else {
				CardFullScreenView(namespace: namespace, show: $show)
			}
		}
		.onTapGesture {
			withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
				show.toggle()
			}
		}
	}
}

struct ShakeEffect: AnimatableModifier {
	
	var delta: CGFloat = 0
	
	var animatableData: CGFloat {
		get {
			delta
		} set {
			delta = newValue
		}
	}
	
	func body(content: Content) -> some View {
		content
			.rotationEffect(Angle(degrees: sin(delta * .pi * 4.0) * CGFloat.random(in: 2...4)))
			.offset(x: sin(delta * 1.5 * .pi * 1.2),
					y: cos(delta * 1.5 * .pi * 1.1))
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView()
	}
}
