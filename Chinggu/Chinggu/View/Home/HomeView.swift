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
	
	@State private var complimentsInGroupCount: Int = 0

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
						//요일 변경하는 버튼
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
						
						//타이틀
						TitleView(title: canBreakBoxes ? "이번 주 칭찬을\n  확인할 시간이에요💞" : "오늘은 어떤 칭찬을\n해볼까요?✍️")
						
						//칭찬 저금통
						HomeComplimentBox(showPopup: $showPopup, complimentsInGroup: $complimentsInGroupCount)
							.overlay {
								if complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count == 0 && !isCompliment {
									NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment)) {
										Image("emptyState")
									}
								}
							}
						
						Spacer()

						//칭찬하기 버튼
						NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment), label: {
							BottomNavigationButton(isCompliment: $isCompliment, width: width)
						})
						.disabled(isCompliment)
					}
					
					Color.clear
					//칭찬하면 나오는 카드 팝업뷰
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
				.onAppear {
					complimentsInGroupCount = complimentManager.fetchComplimentsInGroup(groupID: groupOrder).count
					// 최초 칭찬 작성 시 안내 팝업
					if complimentsInGroupCount == 1, isfirst == true {
						withAnimation(.spring(response: 1.2, dampingFraction: 0.8)) {
							showInfoPopup = true
						}
					}
				}
			}
		}
		.onChange(of: scenePhase) { newPhase in
			compareDates()
//			updateCanBreakBoxes()
		}
	}
	// 요일이 변경 될 때마다 현재 요일과 비교
//	private func updateCanBreakBoxes() {
//		let today = Calendar.current.component(.weekday, from: Date())
//		let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
//
//		if isPastSelectedWeekday() && !isSelectedSameDay {
//			canBreakBoxes = true
//			if scene.complimentCount > 0 {
//				shake = 5
//			}
//		}
//	}
	
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
//		isCompliment = false
//		isSelectedSameDay = false
		lastResetTimeInterval = Date().timeIntervalSince1970
	}
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
