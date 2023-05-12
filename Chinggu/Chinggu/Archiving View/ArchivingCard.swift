//
//  ArchivingCard.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/10.
//

import SwiftUI

struct ArchivingCard: View {
	
	@Binding var compliment: String
	@Binding var groupID: Int16
	@Binding var order: Int16
	@Binding var createDate: Date
	@Binding var cardColor: Color
	
	var body: some View {

		VStack(alignment: .leading){
			Text(compliment)
				.font(.body)
				.fontWeight(.semibold)
				.lineSpacing(5)
				.foregroundColor(.white)
			Spacer()
			HStack{
				Text("\(groupID)")
					.padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
					.foregroundColor(.white)
					.fontWeight(.heavy)
					.background(.black.opacity(0.2))
					.cornerRadius(5)
				Spacer()
				Text(createDate.formatWithDot())
					.opacity(0.3)
				Spacer()
				Text("\(order)")
					.padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
					.foregroundColor(.white)
					.fontWeight(.heavy)
					.background(.black.opacity(0.2))
					.cornerRadius(20)
			}
		}
		.padding(30)
		.background(cardColor)
		.cornerRadius(30)
	}
}
