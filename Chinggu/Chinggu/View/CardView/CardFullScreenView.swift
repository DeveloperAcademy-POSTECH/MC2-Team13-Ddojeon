//
//  CardFullScreenView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardFullScreenView: View {
	
	@AppStorage("group") var groupOrder: Int = 1
	@State var complimentsInGroup: [ComplimentEntity] = []
	@State var groupOrderText: String = ""
	@State var groupStartEndDates: String = ""
	
	var namespace: Namespace.ID
	@Binding var showPopup: Bool
	
	var body: some View {
		ScrollView {
			VStack {
				Image("gradientPresent")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.matchedGeometryEffect(id: "image", in: namespace)
				HStack {
					Text(groupOrderText)
						.font(.headline)
						.matchedGeometryEffect(id: "title", in: namespace)
//						.frame(maxWidth: .infinity, alignment: .leading)
						.foregroundColor(Color("oll"))
					Text(groupStartEndDates)
						.font(.caption)
						.matchedGeometryEffect(id: "subtitle", in: namespace)
//						.frame(maxWidth: .infinity, alignment: .leading)
						.foregroundColor(.gray)
					Spacer()
				}
				.padding()
				
				ScrollView(.vertical, showsIndicators: false) {
					VStack(alignment: .leading, spacing: 10) {
						ForEach(complimentsInGroup, id: \.id) { compliment in
							Text(compliment.compliment ?? "nil compliment")
                                .font(.custom("AppleSDGothicNeo-Regular", size: 17))
                                .padding(.horizontal)
								.lineSpacing(6)
							Divider()
								.padding(4)
						}
					}
					.padding()
				}
				HStack {
					Spacer()
					Button {
						withAnimation(.easeOut) {
							//MainView의 Popup Card를 내림
							showPopup = false
							groupOrder = groupOrder + 1
						}
					} label: {
						Text("닫기")
							.font(.custom("AppleSDGothicNeo-Bold", size: 20))
							.foregroundColor(Color.white)
							.kerning(1)
							.padding(.vertical,6)
							.frame(width: UIScreen.main.bounds.width/1.15, height: 50)
					}
					.background {
						RoundedRectangle(cornerRadius: 15)
							.foregroundColor(Color("oll"))
					}
					
					Spacer()
				}
				.padding()
			}
			.foregroundColor(.black)
		}
		.ignoresSafeArea()
		.background(Color.ddoPrimary)
		.matchedGeometryEffect(id: "background", in: namespace)
		.onAppear(perform: loadCompliments)
	}
	
	private func loadCompliments() {
		complimentsInGroup = PersistenceController.shared.fetchComplimentInGroup(groupID: Int16(groupOrder))
		if let minDate = complimentsInGroup.first?.createDate,
		   let maxDate = complimentsInGroup.last?.createDate {
			let start = minDate.formatWithDot()
			let end = maxDate.formatWithDot()
			groupStartEndDates = "\(start) ~ \(end)"
			groupOrderText = "\(groupOrder)번째 상자"
		}
	}
}
