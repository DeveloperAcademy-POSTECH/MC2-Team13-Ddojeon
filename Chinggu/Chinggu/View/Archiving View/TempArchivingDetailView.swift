//
//  TempArchivingDetailView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/14.
//

import SwiftUI

struct TempArchivingDetailView: View {
	
	@State var compliment: String
	@State var createDate: Date
	@State var order: Int
	@State var cardColor = Color.ddoOrange

	var body: some View {
		VStack(spacing: 30) {
			VStack(alignment: .leading){
				Text(compliment)
					.font(.body)
					.fontWeight(.semibold)
					.lineSpacing(5)
					.foregroundColor(.white)
				Spacer()
				HStack{
					Text("1")
						.padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
						.foregroundColor(.white)
						.fontWeight(.heavy)
						.background(.black.opacity(0.2))
						.cornerRadius(5)
					Spacer()
					Text(createDate.formatWithDot())
						.opacity(0.3)
					Spacer()
					Text("\(order + 1)")
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
			.onChange(of: order) { _ in
				compliment = tempCompliments[order]
				createDate = Calendar.current.date(byAdding: .day, value: -order, to: Date())!
			}
			HStack(spacing: 3) {
				Button {
					if order > 0 {
						order = order - 1
						cardColor = randomColor()
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
				.disabled(order <= 0)
				
				Spacer()
				
				Button {
					if order < 6 {
						order = order + 1
						cardColor = randomColor()
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
				.disabled(order >= 6)
			}
		}
		.padding()
		.background(Color(hex: 0xF9F9F3))
	}
	
	let colors = [
		Color.ddoRed,
		Color.ddoBlue,
		Color.ddoPink,
		Color.ddoGreen,
		Color.ddoOrange
	]
	
	private let tempCompliments = [
		"회사에서 업무를 하고 있는데, 갑자기 상사가 나에게 업무 지적을 했다. 평소와 다를 바가 없었는데 너무 당혹스러웠다. 그래도 회사에 오래 근무하게 되면서 이런 일이 종종 일어난다는 사실을 알기에 조심스럽게 솔직한 의견을 말했다. 이전에는 지적을 모두 수용하는 방향으로 대답했지만, 이제 내 의견을 솔직하게 말하는 사람이 된 것 같다. 말하고 많은 생각이 들었고 심장이 떨렸지만, 점차 나의 의견을 꺼내어 말하는 사람이 되는 과정인 것 같아 매우 뿌듯하다!",
		"오늘은 술을 많이 마셔 택시를 탈까 고민했지만 결국 지하철을 타고 집으로 돌아갔다! 유혹을 참고 택시를 타지 않았다니! 나 자신에게 기특하다!",
		"아침밥 먹기 도전을 시작했다. 건강하게 하루를 시작하니 오전에 집중력이 늘었다. 나는 스스로를 위해서 노력하고 실천하는 사람이야!",
		"클라이언트와 미팅이 있는 날. 너무 긴장한 탓에 아침에 문제가 있기도 했지만, 다행히 약속 시각보다 일찍 도착했다. 미팅은 순조롭게 진행되었고 프로젝트에 참여하기로 결정! 재미있던 부분은 과거, 힘들게 마무리 지은 프로젝트가 있었는데 그 프로젝트를 흥미롭게 보셨다고 말씀해주셨다. 힘이 부쳐 포기할까 많이 고민했는데 끝까지 힘을 내서 마무리한 프로젝트다. 과거의 노력이 빛을 발하는구나! 지금도 미래의 나에게 큰 영향을 주지 않을까? 힘들었지만 끝까지 마무리한 내가 대견하다.",
		"퇴근 후, 동료와 한강에 갔다. 동료는 자전거를 빌려 타자고 제안했지만, 나는 자전거를 타지 못한다고 말했다. 동료는 자전거를 배워보는 게 어떻겠냐고 물어봤다. 나이가 드니 자전거 타기를 배우는 것이 조금은 부끄럽다고 생각했다. 이런 상황이 다시 오지 않을 수 있다는 생각에 배우기로 했다! 생각보다 균형 잡는 것이 매우 어려웠다. 동료가 열심히 가르쳐줬지만 혼자서 타기에는 역부족이었다. 결국, 다음에 다시 만나서 자전거를 배우기로 했다. 오늘 자전거 타기는 실패했지만 시도한 것 자체가 멋진 거지!",
		"최근 몸이 이상함을 느꼈다. 잘 아프지 않은 나인데 도저히 참기 힘들어 병원을 찾았다. 진료 후 근육에 염증이 생겼다는 말을 들었다. 나는 일만 열심히 하면 모든 상황이 좋고 즐거울 줄 알았다. 하지만 이번 계기로 일보다 건강이 더 중요하다는 것을 깨달았다. 나는 건강을 잃게 되면 일과 일상이 파괴될 수 있다는 것을 잊고 살았던 것 같다. 나의 건강을 위해 적절하게 일하고 스스로 상태를 자주 확인해야겠다. 일보다 건강! 이 사실을 깨달아서 다행이야!",
		"동네에 카페가 생겼다. 근처에는 예쁜 카페가 없었기에 달려갔다. 인테리어와 커피 모두 만족스러웠다. 분위기에 취해 셀카를 찍었는데 오늘따라 사진이 잘 나왔다. 사진을 살펴보다 뜻밖의 발견을 했다. 내 눈이 아름답다는 생각을 해본 적이 없었는데 오늘은 햇빛에 반짝이는 눈이 너무나 아름답게 보였다. 집에 돌아온 뒤에도 내 눈만 들여다본 것 같다. 생각보다 더 아름다운 눈을 가졌다는 사실에 기분이 좋았다. 내 눈은 정말 아름답구나!"
	]

	private func randomColor() -> Color {
		let randomIndex = Int.random(in: 0..<colors.count)
		return colors[randomIndex]
	}

}

struct MyPreviewProvider_Previews: PreviewProvider {
	static var previews: some View {
		TempArchivingDetailView(compliment: "test", createDate: Date(), order: 1)
	}
}
