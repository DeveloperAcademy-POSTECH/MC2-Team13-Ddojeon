//
//  TempMainView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct TempMainView: View {
	
	@State private var showPopup = false

	var body: some View {
		ZStack {
			Color.ddoPrimary.ignoresSafeArea()
			VStack {
				HStack {
					Spacer()
					Image(systemName: "captions.bubble.fill").padding()
				}
				Spacer()
				Button("저금통 깨기") {
					showPopup = true
				}
			}
		}
		.popup(isPresented: $showPopup) {
			ZStack {
				CardView()
			}
		}
	}
}

struct Popup<PopupContent: View>: ViewModifier {
	
	@Binding var isPresented: Bool
	let view: () -> PopupContent
	@State private var popupOffset: CGFloat = UIScreen.main.bounds.height

	func body(content: Content) -> some View {
		ZStack {
			content
			if isPresented {
				view()
					.offset(y: popupOffset)
					.onAppear {
						withAnimation(.spring()) {
							popupOffset = 0
						}
					}
			}
		}
	}
}

extension View {

	public func popup<PopupContent: View>(
		isPresented: Binding<Bool>,
		view: @escaping () -> PopupContent) -> some View {
		self.modifier(
			Popup(
				isPresented: isPresented,
				view: view)
		)
	}
}

struct TempMainView_Previews: PreviewProvider {
    static var previews: some View {
        TempMainView()
    }
}
