//
//  CardFullScreenView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardFullScreenView: View {
	
	@AppStorage("group") var groupOrder: Int = 1
    @AppStorage("isSelectedSameDay") private var isSelectedSameDay: Bool = true
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
						.foregroundColor(Color("oll"))
					Text(groupStartEndDates)
						.font(.caption)
						.matchedGeometryEffect(id: "subtitle", in: namespace)
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
				
				VStack {
					let randomIndex = Int.random(in: 0..<quotes.count)
					Text(quotes[randomIndex].text)
					Text(quotes[randomIndex].speaker)
				}
				.multilineTextAlignment(.center)
				.font(.custom("AppleSDGothicNeo-Regular", size: 10))
				.foregroundColor(.gray)

				HStack {
					Spacer()
					Button {
						withAnimation(.easeOut) {
							//MainView의 Popup Card를 내림
							showPopup = false
							groupOrder = groupOrder + 1
                            isSelectedSameDay = true
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
	
	private let quotes: [Quote] = [
		Quote(text: "다정한 말을 아끼지 말라. 특히 자리에 없는 사람들에게.", speaker: "-요한 볼프강 폰 괴테-"),
		Quote(text: "무엇보다도 칭찬은 우리에게 가장 좋은 식사이다.", speaker: "-S. 스마일스-"),
		Quote(text: "많은 인간들 중에서 칭찬할만한 것은 항상 자기 자신뿐이다.\n비평가는 누구나 자기 마음에 든 타임 속에서, 자기숭배를 하고 있음에 불과하다.", speaker: "-생트뵈브-"),
		Quote(text: "한 포기의 풀이 싱싱하게 자라려면 따스한 햇볕이 필요하듯이\n한 인간이 건전하게 성장하려면 칭찬이라는 햇살이 필요하다.", speaker: "-루소-"),
		Quote(text: "칭찬은 선량한 사람들을 더 선하게 하고, 나쁜 사람들을 더 나쁘게 한다.", speaker: "-토마스 풀러-"),
		Quote(text: "칭찬하기를 포기하면 큰 잘못이다.\n매력적인 것을 매력있다고 말하기를 포기할 때는 매력적이라고 생각하는 것도 포기하는 것이기 때문이다.", speaker: "-오스카 와일드-"),
		Quote(text: "너 자신을 사랑하고, 자신의 가치를 인정하라.\n자신을 칭찬하며 성장하고 발전해 나가자.", speaker: "-알버트 아인슈타인-"),
		Quote(text: "자기 자신을 칭찬하는 것은 겸손한 태도의 결과이며, 자신을 성장시키는 원동력이다.", speaker: "-마르쿠스 아우렐리우스-"),
		Quote(text: "자기 자신을 최고로 여기고, 자신의 잠재력을 믿으세요.\n자기 칭찬과 긍정적인 생각은 성공의 열쇠입니다.", speaker: "-알렉스 헤일리-"),
		Quote(text: "자기 자신을 사랑하고 칭찬함으로써 자신에게 가장 큰 힘을 주세요.\n당신의 자신감은 당신을 세계를 변화시킬 수 있는 힘으로 이끌거예요.", speaker: "-루이스 헤이-"),
		Quote(text: "자기 자신을 충분히 사랑하고 칭찬하는 사람은 \n언제나 자신감과 행복을 갖게 될거예요.", speaker: "-칭구-"),
		Quote(text: "자신을 믿고, 자신의 능력을 인정하며, \n자신을 칭찬하세요. 그것이 성공의 첫 걸음입니다.", speaker: "-칭구-"),
		Quote(text: "자기 자신에 대한 긍정적인 이야기를 계속하세요. \n그리고 그 이야기를 믿으세요. 당신을 성공으로 이끌어줄 것입니다.", speaker: "-칭구-"),
		Quote(text: "자기 자신을 사랑하고 칭찬함으로써 자신에게 가장 큰 힘을 주세요.\n당신의 자신감은 당신을 세계를 변화시킬 수 있는 힘으로 이끌거예요.", speaker: "-칭구-"),
		Quote(text: "자기칭찬은 내면의 불확실성을 확신과 자신감으로 바꾸어 줍니다.\n자신을 믿고 칭찬하는 습관을 가지세요.", speaker: "-칭구-"),
	]
}

struct Quote {
	let text: String
	let speaker: String
}
