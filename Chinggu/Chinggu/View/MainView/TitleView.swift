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
			.padding(.top, 14)
	}
}

struct complimentButtonStyle: ButtonStyle {
	var isCompliment: Bool
	var width: CGFloat
	var height: CGFloat

	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.bold()
			.font(.title3)
			.foregroundColor(Color.white)
			.kerning(0.5)
			.padding(.vertical,6)
			.frame(width: width, height: height)
			.background(RoundedRectangle(cornerRadius: 10)
			.foregroundColor(isCompliment ? Color(red: 0.85, green: 0.85, blue: 0.85) : .blue))
	}
}
