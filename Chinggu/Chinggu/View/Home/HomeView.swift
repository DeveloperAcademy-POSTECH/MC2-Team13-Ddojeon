//
//  HomeView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/09.
//

import SwiftUI

struct HomeView: View {
	
	@ObservedObject private var complimentManager = ComplimentManager()
	
	@State private var tempSeletedWeekday: Weekday?
	@State private var shake = 0.0
	@State private var showPopup = false
	@State private var showInfoPopup = false
	
	@AppStorage("group") var groupOrder: Int = 1
	@AppStorage("canBreakBoxes") private var canBreakBoxes = false

	@AppStorage("isfirst") var isfirst: Bool = true
	@AppStorage("selectedWeekday") private var selectedWeekday: String = Weekday.today.rawValue
	@AppStorage("isCompliment") private var isCompliment: Bool = false
	@AppStorage("lastResetTimeInterval") private var lastResetTimeInterval: TimeInterval = Date().timeIntervalSince1970
	
	@State private var complimentsInGroupCount: Int = 7

	var lastResetDate: Date {
		let lastResetTime = Date(timeIntervalSince1970: lastResetTimeInterval)
		return lastResetTime
	}
	
	@Environment(\.scenePhase) var scenePhase
	
	var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width - geometry.safeAreaInsets.leading - geometry.safeAreaInsets.trailing - 40
			let height = width * 424 / 350
			
			NavigationStack {
				ZStack {
					Color.ddoPrimary.ignoresSafeArea()
					VStack {
						//MARK: 요일 변경하는 버튼
						HomeViewTop()
						
						VStack(spacing: 0) {
							Divider()
							Rectangle()
								.fill(Color(.systemGray3))
								.frame(height: 5)
								.opacity(0.15)
							Divider()
						}
						.padding(.bottom)
						
						// 타이틀
						TitleView(title: canBreakBoxes ? "이번 주 칭찬을\n  확인할 시간이에요💞" : "오늘은 어떤 칭찬을\n해볼까요?✍️")
						
						//MARK: 칭찬 저금통
						HomeComplimentBox(showPopup: $showPopup, complimentsInGroup: $complimentsInGroupCount)

						//MARK: subtitle
						if complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 7 {
							subTitleView(title: "주간 칭찬은 최대 7개 까지만 가능해요.")
//						} else if canBreakBoxes && scene.boxes.count > 0  {
//							subTitleView(title: "칭찬 상자를 톡! 눌러주세요.")
						} else {
							subTitleView(title: "긍정의 힘은 복리로 돌아와요. 커밍쑨!")
						}
						
						
						Spacer()

						// 칭찬돌 추가하는 버튼
						NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment), label: {
							Text(isCompliment ? "오늘 칭찬 끝!" : "칭찬하기")
								.bold()
								.font(.title3)
								.foregroundColor(Color.white)
								.kerning(0.5)
								.padding(.vertical,6)
								.frame(width: width, height: 56)
						})
						.background {
							RoundedRectangle(cornerRadius: 10)
								.foregroundColor(isCompliment || complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 7 ? .gray : .blue)
						}
						.disabled(isCompliment)
						.disabled(complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 7)
					}
					if complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 0 && !isCompliment {
						NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment)) {
							Image("emptyState")
								.offset(y: 45)
						}
					}
					
					Color.clear
						.popup(isPresented: $showPopup) {
							CardView(showPopup: $showPopup)
						}
					// 최초 칭찬 작성 시 안내 팝업
						.popup(isPresented: $showInfoPopup) {
							InfoPopupView(showInfoPopup: $showInfoPopup)
						}
				}
//				.onChange(of: groupOrder, perform: { newValue in
//					complimentManager.fetchComplimentsInGroup(groupID: groupOrder) = PersistenceController.shared.fetchComplimentInGroup(groupID: Int16(newValue))
//				})
				.onChange(of: scenePhase) { newPhase in
					print("scene change")
					compareDates()
					updateCanBreakBoxes()
				}
				.onAppear {
					// 최초 칭찬 작성 시 안내 팝업
//					complimentsInGroup = PersistenceController.shared.fetchComplimentInGroup(groupID: Int16(groupOrder))
//					if Compliment.count == 1, isfirst == true {
//						withAnimation(.spring(response: 1.2, dampingFraction: 0.8)) {
//							showInfoPopup = true
//						}
//					}
				}
			}
		}
	}
	// 요일이 변경 될 때마다 현재 요일과 비교
	private func updateCanBreakBoxes() {
		let today = Calendar.current.component(.weekday, from: Date())
		let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
		
//		if isPastSelectedWeekday() && !isSelectedSameDay {
//			canBreakBoxes = true
//			if scene.complimentCount > 0 {
//				shake = 5
//			}
//		}
	}
	
	// 선택한 요일이 지났는지 여부 판단
	func isPastSelectedWeekday() -> Bool {
		let calendar = Calendar.current
		var selectedWeekdayNumber = 0
		// 선택된 요일 Int로 뽑기
		let weekdayArray = Weekday.allCases
		for (index, weekday) in weekdayArray.enumerated() {
			if weekday.rawValue == selectedWeekday {
				selectedWeekdayNumber = index + 2
				if selectedWeekdayNumber >= 7 {
					selectedWeekdayNumber %= 7
				}
				break
			}
		}
		let selectedWeekdayComponent = DateComponents(weekday: selectedWeekdayNumber)
		print("selectedWeekdayComponent",selectedWeekdayComponent)
		// 현재 날짜가 선택된 날짜와 동일하거나 지났다면
		guard let selectedDate = calendar.nextDate(after: Date(), matching: selectedWeekdayComponent, matchingPolicy: .nextTime) else {
			return false
		}
		return true
	}
	
	// 초기화 날짜 비교
	private func compareDates() {
		let calendar = Calendar.current
		if !calendar.isDateInToday(lastResetDate) {
			resetTimeButton()
		}
	}
	
	// 버튼 초기화
	private func resetTimeButton() {
		isCompliment = false
//		isSelectedSameDay = false
		lastResetTimeInterval = Date().timeIntervalSince1970
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
