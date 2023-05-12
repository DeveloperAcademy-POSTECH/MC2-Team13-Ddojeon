//
//  ArchivingViewTest.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingView: View {
	
	@FetchRequest(
		entity: ComplimentEntity.entity(),
		sortDescriptors: []
	) var Compliment: FetchedResults<ComplimentEntity>
	@AppStorage("group") var groupOrder: Int = UserDefaults.standard.integer(forKey: "groupID")

	var body: some View {
		NavigationStack{
			VStack(alignment: .leading){
				Text("\(groupOrder)번의 저금통을 깨고,\n\(Compliment.count)번 칭찬했어요.")
					.font(.title3)
					.fontWeight(.bold)
					.padding(.leading)
				
				List {
					ForEach((0..<$groupOrder.wrappedValue).reversed(), id: \.self) { index in
							Section(header: Text("\(index)번째 저금통")) {
								ForEach(Compliment, id: \.self.id) { compliments in
									if compliments.groupID == index {
										NavigationLink(
											destination: ArchivingDetailView(complimentOrder: compliments.order).toolbarRole(.editor), label: {
											VStack(alignment: .leading, spacing: 8){
												let currentDate = compliments.createDate
												let strDate = currentDate?.formatWithDot()
												Text(compliments.compliment ?? "")
													.font(.headline)
													.lineLimit(2)
												Text(strDate ?? "")
													.font(.subheadline)
													.foregroundColor(.gray)
													.lineLimit(1)
											}
										})
									} else { }
								}
						}
					}.onDelete(perform: delete)
				}
				.scrollContentBackground(.hidden)
				.toolbar {
					EditButton()
				}
			}
			.accentColor(.red)
			.padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
			.background(Color(hex: 0xF9F9F3))
		}
	}
	
	private func delete(indexset: IndexSet) {
		guard let index = indexset.first else { return }
		let selectedEntity = Compliment[index]
		PersistenceController.shared.deleteCompliment(compliment: selectedEntity)
	}
}
