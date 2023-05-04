//
//  ShakePresent.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct ShakePresent: View {
	
	@Namespace var animation
	@State private var shakeAnimation = false

	var body: some View {
		VStack {
			Present(shakeAnimation: $shakeAnimation)
		}
	}
}

struct Present: View {
	
	@State var numberOfShakes: CGFloat = 0
	@Binding var shakeAnimation: Bool

	var body: some View {
		
		RoundedRectangle(cornerRadius: 15)
			.frame(width: 350, height: 400)
			.foregroundColor(.clear)
			.overlay {
				VStack {
					Image("presentHead")
						.resizable()
						.frame(width: 340, height: 100)
						.modifier(ShakeEffect(delta: numberOfShakes))
					
					Image("presentBody")
						.resizable()
						.frame(width: 300, height: 220)
						.modifier(ShakeEffect(delta: numberOfShakes))
				}
			}
			.onAppear() {
				withAnimation(.linear(duration: 1.5)) {
					if numberOfShakes == 0 {
						numberOfShakes = 8
					} else {
						numberOfShakes = 0
					}
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

struct ShakePresent_Previews: PreviewProvider {
    static var previews: some View {
        ShakePresent()
    }
}
