//
//  CardPopupView.swift
//  mc2Test
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardPopupView: View {
	
	var namespace: Namespace.ID
	
	var body: some View {
		LottieView(filename: "cardAnimation.json", loopState: false)
			.background(LinearGradient(gradient: Gradient(colors: [Color.ddoYellow, Color.ddoPrimary]), startPoint: .top, endPoint: .bottom))
			.clipShape(RoundedRectangle(cornerRadius: 15))
			.frame(width: 350, height: 412)
			.matchedGeometryEffect(id: "image", in: namespace)
	}
}

struct CardPopupView_Previews: PreviewProvider {
	
	@Namespace static var namespace
	
    static var previews: some View {
		CardPopupView(namespace: namespace)
    }
}
