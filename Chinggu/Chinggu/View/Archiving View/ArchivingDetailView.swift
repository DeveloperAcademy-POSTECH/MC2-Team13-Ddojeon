//
//  ArchivingDetailView.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingDetailView: View {
	
	@AppStorage("group") var groupOrder: Int = 1
	@FetchRequest(
		entity: ComplimentEntity.entity(),
		sortDescriptors: []
	) var allCompliments: FetchedResults<ComplimentEntity>

	@State var complimentOrder: Int16
	@State private var compliment: String = "칭찬 글"
	@State private var groupID: Int16 = 6
	@State private var order: Int16 = 45
	@State private var createDate: Date = Date()
	
	@State private var cardColor = Color.ddoOrange
	
	private let colors = [
		Color("ddoTip1_2"),
		Color("ddoTip2_2"),
		Color("ddoTip3_2"),
		Color("ddoTip4_2"),
		Color("ddoTip5_2"),
		Color("ddoTip6_2"),
		Color("ddoTip7_2"),
		Color("ddoTip8_2"),
		Color("ddoTip9_2"),
		Color("ddoTip10_2")
		
	]

	var body: some View {
		VStack {
			ArchivingCard(compliment: $compliment,
						  groupID: $groupID,
						  order: $order,
						  createDate: $createDate,
						  cardColor: randomColor())
//			.padding()
			.padding(EdgeInsets(top: 0, leading: 5, bottom: 30, trailing: 5))
				.onAppear { loadCompliment() }
			
			HStack(spacing: 3) {
				Button {
					if complimentOrder < allCompliments.count {
						complimentOrder += 1
						loadCompliment()
					}
				} label: {
					//최신 칭찬으로 가는 버튼
					Text("<")
						.fixedSize()
						.frame(maxWidth: .infinity)
						.font(.title3)
						.fontWeight(.bold)
						.foregroundColor(.white)
						.padding()
						.background(complimentOrder <= 1 ? .gray : .black.opacity(0.7))
						.cornerRadius(15)
				}
				.disabled(complimentOrder >= allCompliments.count)
				
				Spacer()
				
				Button {
					if complimentOrder > 1 {
						complimentOrder -= 1
						loadCompliment()
					}
				} label: {
					//오래된 칭찬으로 가는 버튼
					Text(">")
						.fixedSize()
						.frame(maxWidth: .infinity)
						.font(.title3)
						.fontWeight(.bold)
						.foregroundColor(.white)
						.padding()
						.background(complimentOrder >= allCompliments.count ? .gray :  .black.opacity(0.7))
						.cornerRadius(15)
				}
				.disabled(complimentOrder <= 1)
			}
		}
		.padding()
		.padding(.top)
		.background(Color(hex: 0xF9F9F3))
	}
	
	private func randomColor() -> Color {
		let randomIndex = Int.random(in: 0..<colors.count)
		return colors[randomIndex]
	}
	
	private func loadCompliment() {
		if let complimentEntity = PersistenceController.shared.loadCompliment(order: complimentOrder) {
			compliment = complimentEntity.compliment ?? ""
			groupID = complimentEntity.groupID
			order = complimentEntity.order
			createDate = complimentEntity.createDate ?? Date()
		}
	}
}

struct ArchivingDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ArchivingDetailView(complimentOrder: 2)
			.previewDevice("iPhone SE (3rd generation)")
	}
}

