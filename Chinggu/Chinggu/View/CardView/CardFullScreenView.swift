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
                    HStack(spacing:4) {
                        Text(groupOrderText)
                            .font(Font.system(size:18).weight(.heavy))
                            .matchedGeometryEffect(id: "title", in: namespace)
                            .foregroundColor(Color("oll"))
                       
                        Image(systemName: "gift")
                            .font(Font.system(size:18).weight(.heavy))
                            .foregroundColor(Color("oll"))
                        
                      Spacer()
                            .frame(width: 10)
                        
                        Text(groupStartEndDates)
                            .font(.caption)
                            .matchedGeometryEffect(id: "subtitle", in: namespace)
                            .foregroundColor(.gray)
                      Spacer()
                    }
                    .padding()
                    
                                    
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(complimentsInGroup, id: \.id) { compliment in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white)
                                    Text(compliment.compliment ?? "nil compliment")
                                        .font(.custom("AppleSDGothicNeo-Regular", size: 17))
                                        .padding()
                                        .lineSpacing(6)
                                }
                                .padding(.vertical, 4)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    // 명언
                    VStack {
                        let randomIndex = Int.random(in: 0..<quotes.count)
                        Text(quotes[randomIndex].text)
                            .padding(.bottom, 2)
                        Text(quotes[randomIndex].speaker)
                    }
                    .multilineTextAlignment(.center)
                    .font(.custom("AppleSDGothicNeo-Regular", size: 12))
                    .lineSpacing(2)
                    .foregroundColor(.gray)
                    .padding()
                    
                    // 닫기 버튼
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
        Quote(text: "할 수 있다고 믿으면 이미 절반은 이룬 것입니다.", speaker: "-시어도어 루즈벨트-"),
        Quote(text: "위대한 일을 하는 유일한 방법은 자신이 하는 일을 사랑하는 것입니다.", speaker: "-스티브 잡스-"),
        Quote(text: "성공은 최종적인 것이 아니며, 실패는 치명적인 것이 아닙니다.\n중요한 것은 계속할 수 있는 용기입니다.", speaker: "-윈스터 처칠-"),
        Quote(text: "자신과 자신의 모든 것을 믿으세요.\n 당신 안에는 어떤 장애물보다 더 위대한 무언가가 있다는 것을 알아라.", speaker: "-크리스천 D.라슨-"),
        Quote(text: "성공이 행복의 열쇠는 아닙니다.행복이 성공의 열쇠입니다.\n자신이 하는 일을 사랑한다면 성공할 수 있습니다.", speaker: "-알버트 슈바이처-"),
        Quote(text: "사람을 찬미할 수 있는 사람이야말로\n참답게 명예스런 사람이다.", speaker: "-탈무드-"),
        Quote(text: "상대의 장점을 먼저 칭찬하고\n그 다음 단점을 지적하라.", speaker: "-앤드류 매튜스-"),
        Quote(text: "아름다운 일에 대해서 칭찬을 아끼지 않는다면\n우리 자신은 그 아름다운 일에 참여하는 것이 된다.", speaker: "-라 로슈푸코-"),
        Quote(text: "시간은 한정되어 있으니\n다른 사람의 인생을 살면서 시간을 낭비하지 마세요.", speaker: "-스티브 잡스-"),
        Quote(text: "당신이 될 운명의 유일한 사람은\n당신이 되기로 결심한 사람입니다.", speaker: "-랄프 왈도 에머슨-"),
        Quote(text: "마음속의 두려움에 휘둘리지 마세요.\n마음속의 꿈에 이끌리십시오.", speaker: "-로이 T.베넷-"),
        Quote(text: "인생에서 가장 큰 영광은 넘어지지 않는 것이 아니라\n넘어질 때마다 다시 일어서는 것입니다.", speaker: "-스티브 잡스-"),
        Quote(text: "성공은 목적지가 아니라 여정에 관한 것이다.", speaker: "-지그 지글러-"),
        Quote(text: "미래는 내일이 아니라 오늘 시작됩니다.", speaker: "-교황 요한 바오로 2세-"),
        Quote(text: "끔 쿰을 꾸고 과감히 실패해보세요.", speaker: "-노먼 본-"),
        Quote(text: "도전은 삶을 흥미롭게 만들고\n이를 극복하는 것은 삶을 의미 있게 만듭니다.", speaker: "-조슈아J.마린-"),
        Quote(text: "인생은 우연히 좋아지는 것이 아니라\n변화를 통해 좋아집니다.", speaker: "-짐 론-"),
        Quote(text: "미래는 꿈의 아름다움을 믿는 자의 것이다.", speaker: "-엘리너 루즈벨트-"),
        Quote(text: "성공은 실패의 부재가 아니라\n실패를 통한 끈기입니다.", speaker: "-아이샤 타일러-"),
        Quote(text: "기회는 우연히 찾아오는 것이 아닙니다.\n기회는 스스로 만드는 것입니다.", speaker: "-크리스그로서-"),
        Quote(text: "멈추지 않는 한 얼마나 천천히 가느냐는 중요하지 않다.", speaker: "-공자-"),
        Quote(text: "성공은 매일 반복되는 작은 노력의 총합입니다.", speaker: "-로버트 콜리어-"),
        Quote(text: "동기 부여는 시작의 원동력입니다. 습관은 당신을 계속 나아가게 하는 힘입니다.", speaker: "-짐론-"),
        Quote(text: "시작하기 위해 대단할 필요는 없지만,\n대단해지기 위해 시작해야 합니다.", speaker: "-지그 지글러-"),
        Quote(text: "앞서 나가는 비결은\n시작하는 것이다.", speaker: "-마크 트웨인-"),
        Quote(text: "인생에서 저지르는 가장 큰 실수는\n실수할까 봐 계속 두려워하는 것이다.", speaker: "-엘버트 허바드-"),
	]
}

struct Quote {
	let text: String
	let speaker: String
}
