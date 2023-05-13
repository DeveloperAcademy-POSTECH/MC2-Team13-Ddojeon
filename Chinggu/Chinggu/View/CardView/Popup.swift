//
//  Popup.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/14.
//

import SwiftUI

struct Popup<PopupContent: View>: ViewModifier {
	
	@Binding var isPresented: Bool
	let view: () -> PopupContent
	
	func body(content: Content) -> some View {
		ZStack {
			content
			if isPresented {
				view()
					.transition(.move(edge: .bottom))
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

