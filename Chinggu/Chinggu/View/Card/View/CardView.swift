//
//  CardView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardView: View {
	@Namespace var namespace
    @StateObject var viewModel = CardViewModel()
    @Binding var showPopup: Bool

	var body: some View {
		ZStack {
			LottieView(filename: "cardBeforeAnimation", loopState: false, contentMode: .scaleAspectFill)
				.ignoresSafeArea()
				.transaction { transaction in
					transaction.animation = nil
				}
            if !viewModel.showFullScreen {
				VStack {
					CardPopupView(namespace: namespace)
					Text("카드를 눌러 내용을 확인하세요")
						.bold()
						.foregroundColor(.white)
                        .opacity(viewModel.showText ? 1 : 0)
                        .onAppear(perform: viewModel.showTextWithDelay)
				}
			} else {
                CardFullScreenView(showPopup: $showPopup, namespace: namespace)
			}
		}
        .onTapGesture(perform: viewModel.toggleFullScreen)
	}
}

struct CardView_Previews: PreviewProvider {
	static var previews: some View {
		CardView(showPopup: .constant(true))
	}
}
