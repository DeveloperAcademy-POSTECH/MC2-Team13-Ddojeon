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
	@State var compliment: String = "칭찬 글"
	@State var groupID: Int16 = 6
	@State var order: Int16 = 45
	@State var createDate: Date = Date()
	
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
		VStack(spacing: 30) {
			ArchivingCard(compliment: $compliment,
						  groupID: $groupID,
						  order: $order,
						  createDate: $createDate,
						  cardColor: randomColor())
				.onAppear { loadCompliment() }
			
			HStack(spacing: 3) {
				Button {
					if complimentOrder > 1 {
						complimentOrder -= 1
						loadCompliment()
					}
				} label: {
					Text("이전 칭찬")
						.frame(maxWidth: .infinity)
						.font(.title3)
						.fontWeight(.bold)
						.foregroundColor(.white)
						.padding(EdgeInsets(top: 18, leading: 20, bottom: 18, trailing: 20))
						.background(.black.opacity(0.7))
						.cornerRadius(15)
				}
				.disabled(complimentOrder <= 1)
				
				Spacer()
				
				Button {
					if complimentOrder < allCompliments.count {
						complimentOrder += 1
						loadCompliment()
					}
				} label: {
					Text("다음 칭찬")
						.frame(maxWidth: .infinity)
						.font(.title3)
						.fontWeight(.bold)
						.foregroundColor(.white)
						.padding(EdgeInsets(top: 18, leading: 20, bottom: 18, trailing: 20))
						.background(.black.opacity(0.7))
						.cornerRadius(15)
				}
				.disabled(complimentOrder >= allCompliments.count)
			}
		}
		.padding()
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
    }
}

