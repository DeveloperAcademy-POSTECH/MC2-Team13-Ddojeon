//
//  CardPopupView.swift
//  mc2Test
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardPopupView: View {
	
	var namespace: Namespace.ID
	@Binding var show: Bool
	@State var numberOfShakes: CGFloat = 0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 12) {
			Spacer()
			VStack {
				Color.clear
			}
			.padding()
		}
		.background(
			VStack {
				Image("present")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.matchedGeometryEffect(id: "image", in: namespace)
					.modifier(ShakeEffect(delta: numberOfShakes))
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
		)
		.background {
			RoundedRectangle(cornerRadius: 15)
				.foregroundColor(Color.ddoPrimary)
				.frame(width: 340, height: 400)
				.matchedGeometryEffect(id: "background", in: namespace)
		}
		.frame(height: 200)
		.padding()
	}
}

struct CardPopupView_Previews: PreviewProvider {
	
	@Namespace static var namespace
	
    static var previews: some View {
		CardPopupView(namespace: namespace, show: .constant(true))
    }
}
