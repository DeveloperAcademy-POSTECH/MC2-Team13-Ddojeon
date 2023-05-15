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
				Text(groupStartEndDates)
					.font(.headline)
					.matchedGeometryEffect(id: "title", in: namespace)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
				ScrollView(.vertical, showsIndicators: false) {
					VStack(alignment: .leading, spacing: 10) {
						ForEach(complimentsInGroup, id: \.id) { compliment in
							Text(compliment.compliment ?? "nil compliment")
								.padding(.leading)
							Divider()
						}
					}
					.padding()
				}
				HStack {
					Spacer()
					Button {
						withAnimation(.easeOut(duration: 0.5)) {
							//MainView의 Popup Card를 내림
							showPopup = false
							groupOrder = groupOrder + 1
						}
					} label: {
						Text("닫기")
							.font(.title3)
							.foregroundColor(.white)
							.padding()
					}
					.background {
						RoundedRectangle(cornerRadius: 15)
							.foregroundColor(.blue)
							.foregroundColor(.ddoBlue)
							.frame(width: 80, height: 40)
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
			let formatter = DateFormatter()
			formatter.dateFormat = "yyyy.MM.dd"
			let start = formatter.string(from: minDate)
			let end = formatter.string(from: maxDate)
			groupStartEndDates = "\(groupOrder)번째 저금통 \(start) ~ \(end)"
		}
	}
}
