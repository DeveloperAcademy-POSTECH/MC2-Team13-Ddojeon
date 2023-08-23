//
//  TitleView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/06.
//

import SwiftUI

struct TitleView: View {
	var title: String
	var body: some View {
		Text(title)
			.tracking(-0.3)
			.multilineTextAlignment(.center)
			.bold()
			.font(.title)
			.foregroundColor(Color("ddoFont"))
			.lineSpacing(5)
			.padding(.bottom, 25)
	}
}

struct subTitleView: View {
	var title: String
	
	var body: some View {
		Text(title)
			.font(.subheadline)
			.fontWeight(.semibold)
			.foregroundColor(.gray)
			.padding(.top)
	}
}

struct bottomButtonStyle: ButtonStyle {
	var isCompliment: Bool
	var width: CGFloat
	var height: CGFloat

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.bold()
			.font(.title3)
			.foregroundColor(Color.white)
			.frame(width: width, height: height)
			.background(RoundedRectangle(cornerRadius: 10)
				.foregroundColor(isCompliment ? .gray : .blue))
			.disabled(isCompliment)
	}
}

struct ShakeEffect: AnimatableModifier {
	var delta: CGFloat = 0
	
	var animatableData: CGFloat {
		get { delta }
		set { delta = newValue }
	}
	
	func body(content: Content) -> some View {
		content
			.rotationEffect(Angle(degrees: sin(delta * .pi * 4.0) * CGFloat.random(in: 0.5...1.5)))
			.offset(x: sin(delta * 1.5 * .pi * 1.2),
					y: cos(delta * 1.5 * .pi * 1.1))
	}
}

struct BottomNavigationButton: View {
	@Binding var isCompliment: Bool
	
	var width: CGFloat
	var buttonText: String {
		return isCompliment ? "오늘 칭찬 끝!" : "칭찬하기"
	}
	
	var buttonColor: Color {
		return isCompliment ? .gray : .blue
	}
	
	var body: some View {
		Text(buttonText)
			.bold()
			.font(.title3)
			.foregroundColor(.white)
			.kerning(0.5)
			.padding(.vertical, 6)
			.frame(width: width, height: 56)
			.background(buttonColor)
			.cornerRadius(10)
		
//			.background {
//				RoundedRectangle(cornerRadius: 10)
//					.foregroundColor(isCompliment || complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 7 ? .gray : .blue)
//			}
//			.disabled(complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 7)

	}
}
