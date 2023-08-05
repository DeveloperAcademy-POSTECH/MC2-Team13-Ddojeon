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
