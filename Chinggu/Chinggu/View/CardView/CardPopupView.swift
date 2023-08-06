//
//  CardPopupView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardPopupView: View {
	
	var namespace: Namespace.ID
	
	var body: some View {
		LottieView(filename: "cardAnimation.json", loopState: false, playState: .constant(true))
			.background(LinearGradient(gradient: Gradient(colors: [Color.ddoYellow, Color.ddoPrimary]), startPoint: .top, endPoint: .bottom))
			.clipShape(RoundedRectangle(cornerRadius: 15))
			.aspectRatio(350/412, contentMode: .fit)
			.matchedGeometryEffect(id: "image", in: namespace)
	}
}
