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
	@State private var rcolor = ColorStyle.randomColor()

	var body: some View {
		VStack {
			ArchivingCard(compliment: $compliment,
						  groupID: $groupID,
						  order: $order,
						  createDate: $createDate,
						  cardColor: rcolor)
			.padding(Metric.ArchivingCardPaddingInsets)
			.onAppear { loadCompliment() }
			
			HStack {
				TowardsButton(
					complimentOrder: $complimentOrder,
					rcolor: $rcolor,
					allComplimentsCount: allCompliments.count,
					loadCompliment: loadCompliment,
					getRandomColor: ColorStyle.randomColor,
					direction: .forward
				)

				Spacer()
				
				//버튼 oll 0.9
				//background oll 0.1
				//font black 0.3
				Text("\(groupID)번째 상자ㅣ\(order)번째 칭찬")
					.font(.subheadline.bold())
					.foregroundColor(.black.opacity(0.3))
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.fill(Color("oll").opacity(0.1))
					)

				Spacer()
				
				TowardsButton(
					complimentOrder: $complimentOrder,
					rcolor: $rcolor,
					allComplimentsCount: allCompliments.count,
					loadCompliment: loadCompliment,
					getRandomColor: ColorStyle.randomColor,
					direction: .backward
				)
			}
		}
		.padding()
		.padding(.top)
		.background(Color.ddoPrimary)
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

fileprivate struct TowardsButton: View {
	
	@Binding var complimentOrder: Int16
	@Binding var rcolor: Color
	let allComplimentsCount: Int
	let loadCompliment: () -> Void
	let getRandomColor: () -> Color
	let direction: ButtonDirection
	let buttonCornerRadius: CGFloat = 15

	enum ButtonDirection {
		case forward
		case backward

		func updateOrder(order: inout Int16, total: Int) {
			switch self {
			case .forward:
				if order < total {
					order += 1
				}
			case .backward:
				if order > 1 {
					order -= 1
				}
			}
		}
		
		func disabledCondition(order: Int16, total: Int) -> Bool {
			switch self {
			case .forward:
				return order >= total
			case .backward:
				return order <= 1
			}
		}

		func activeBackground(order: Int16, total: Int) -> Color {
			return disabledCondition(order: order, total: total) ? Color("oll").opacity(0.1) : .black.opacity(0.7)
		}
	}

	var body: some View {
		Button {
			rcolor = getRandomColor()
			direction.updateOrder(order: &complimentOrder,
								  total: allComplimentsCount)
			loadCompliment()
		} label: {
			Image(systemName: direction == .forward ? "arrow.backward" : "arrow.forward")
				.padding()
				.foregroundColor(.white)
				.background(direction.activeBackground(order: complimentOrder,
													   total: allComplimentsCount))
				.cornerRadius(buttonCornerRadius)
		}
		.disabled(direction.disabledCondition(order: complimentOrder,
											  total: allComplimentsCount))
	}
}

struct ArchivingDetailView_Previews: PreviewProvider {
	static var previews: some View {
		ArchivingDetailView(complimentOrder: 2)
			.previewDevice("iPhone SE (3rd generation)")
	}
}

