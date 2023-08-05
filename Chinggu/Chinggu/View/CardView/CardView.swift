//
//  CardView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardView: View {
	
	@Namespace var namespace
	@State private var showFullScreen = false
	@Binding var showPopup: Bool
	@State private var showText = false

	var body: some View {
		ZStack {
			LottieView(filename: "cardBeforeAnimation", loopState: false, contentMode: .scaleAspectFill, playState: .constant(true))
				.ignoresSafeArea()
				.transaction { transaction in
					transaction.animation = nil
				}
			if !showFullScreen {
				VStack {
					CardPopupView(namespace: namespace)
					Text("카드를 눌러 내용을 확인하세요")
						.bold()
						.foregroundColor(.white)
						.opacity(showText ? 1 : 0)
						.onAppear {
							withAnimation (.easeInOut.delay(5)) {
								showText = true
							}
						}
				}
			} else {
				CardFullScreenView(namespace: namespace, showPopup: $showPopup)
			}
		}
		.onTapGesture {
			withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
				showFullScreen = true
			}
		}
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView(showPopup: .constant(true))
	}
}
