//
//  MainView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/06.
//

import SwiftUI
import SpriteKit

// MARK: 메인 뷰
struct MainView: View {
	
	@ObservedObject private var gameState = GameState()
	@EnvironmentObject var mainStore: MainStore
	@Environment(\.scenePhase) var scenePhase

	@AppStorage(UserDefaultsKeys.isfirst) var isfirst: Bool = true
	@AppStorage(UserDefaultsKeys.groupOrder) var groupOrder: Int = 1
	@AppStorage(UserDefaultsKeys.isCompliment) private var isCompliment: Bool = false
	@AppStorage(UserDefaultsKeys.lastResetTimeInterval) private var lastResetTimeInterval: TimeInterval = Date().timeIntervalSince1970
	@AppStorage(UserDefaultsKeys.selectedWeekday) private var selectedWeekday: String = Weekday.today.rawValue

	@State private var showBreakAlert = false
	@State private var shake = 0.0
	@State private var showPopup = false
	@State private var showInfoPopup = false
	
	
	var body: some View {
		GeometryReader { geometry in
			let width = geometry.size.width - geometry.safeAreaInsets.leading - geometry.safeAreaInsets.trailing - 40
			let height = width * 424 / 350
			
			NavigationStack {
				ZStack {
					Color.ddoPrimary.ignoresSafeArea()
					VStack {
						
						//MARK: 요일 변경하는 버튼
						ChangeWeekdayView()
						
						VStack(spacing: 0) {
							Divider()
							Rectangle()
								.fill(Color(.systemGray3))
								.frame(height: 5)
								.opacity(0.15)
							Divider()
						}
						.padding(.bottom, 30)
						
						//MARK: 타이틀
						TitleView(title: (gameState.canBreakBoxes && gameState.scene.boxes.count > 0) ? "이번 주 칭찬을\n  확인할 시간이에요💞" : "오늘은 어떤 칭찬을\n해볼까요?✍️")
						
						//MARK: 칭찬 저금통
						SpriteView(scene: gameState.scene)
							.frame(width: width, height: height)
							.cornerRadius(26)
							.onTapGesture {
								if gameState.scene.boxes.count > 0 && gameState.canBreakBoxes {
									showBreakAlert = true
								}
							}
						// 만기일 개봉 얼럿
							.alert(isPresented: $showBreakAlert) {
								Alert(title: Text("칭찬 상자를 열어볼까요?"), primaryButton: .default(Text("네")) {
									// 저금통 초기화
									withAnimation(.easeOut(duration: 1)) {
										gameState.scene.resetBoxes()
										gameState.scene.complimentCount = 0
										showPopup = true
									}
								}, secondaryButton:.cancel(Text("아니요")))
							}
						// 애니메이션
							.modifier(ShakeEffect(delta: shake))
							.onReceive(gameState.$shake) { newValue in
								withAnimation(.easeOut(duration: 1.5)) {
									if gameState.canBreakBoxes {
										if gameState.shake == 0 {
											gameState.shake = newValue
										} else {
											gameState.shake = 0
										}
									}
								}
							}
							.onAppear {
								afterComplimentCanBreakBox(width: width, height: height)
							}
						
						subTitleView(title: (gameState.canBreakBoxes && gameState.scene.boxes.count > 0) ? "칭찬 상자를 톡! 눌러주세요" : "긍정의 힘은 복리로 돌아와요. 커밍쑨!")
						
						Spacer()
						
						//MARK: 칭찬하기 버튼
						Button {
							
						} label: {
							NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment)) {
								Text(isCompliment ? "오늘 칭찬 끝!" : "칭찬하기")
							}
						}
						.buttonStyle(complimentButtonStyle(isCompliment: isCompliment, width: width, height: 56))
						.disabled(isCompliment)
					}
					
					if mainStore.complimentsInGroup.count == 0 && !isCompliment {
						NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment)) {
							Image("emptyState")
								.offset(y: 45)
						}
					}
					
					Color.clear
						.popup(isPresented: $showPopup) {
							CardView(showPopup: $showPopup)
						}
					//MARK: 최초 칭찬 작성 시 안내 팝업
						.popup(isPresented: $showInfoPopup) {
							InfoPopupView(showInfoPopup: $showInfoPopup)
						}
				}
				.onChange(of: groupOrder, perform: { newValue in
					mainStore.complimentsInGroup = PersistenceController.shared.fetchComplimentInGroup(groupID: Int16(newValue))
				})
				.onChange(of: scenePhase) { newPhase in
					compareDates()
					gameState.updateCanBreakBoxes()
				}
				.onAppear {
//					mainStore.complimentsInGroup = PersistenceController.shared.fetchComplimentInGroup(groupID: Int16(groupOrder))
					// 최초 칭찬 작성 시 안내 팝업
					if mainStore.complimentsInGroup.count == 1, isfirst == true {
						withAnimation(.spring(response: 1.2, dampingFraction: 0.8)) {
							showInfoPopup = true
						}
					}
				}
				
			}
		}
	}
	
	// 초기화 날짜 비교
	private func compareDates() {
		let calendar = Calendar.current
		if !calendar.isDateInToday(Date(timeIntervalSince1970: lastResetTimeInterval)) {
			isCompliment = false
			gameState.isSelectedSameDay = false
			lastResetTimeInterval = Date().timeIntervalSince1970
		}
	}
	
	private func afterComplimentCanBreakBox(width: CGFloat, height: CGFloat) {
		//GameScene의 값을 최신화 하기 위함
		if mainStore.complimentsInGroup.count > gameState.scene.complimentCount {
			gameState.scene.addBox(at: CGPoint(x: gameState.scene.size.width/2, y: gameState.scene.size.height - 50))
			if gameState.canBreakBoxes {
				shake = 4
			}
		}
		
		gameState.scene.size = CGSize(width: width, height: height)
		gameState.scene.complimentCount = mainStore.complimentsInGroup.count
		gameState.updateCanBreakBoxes()
		
		gameState.scene.scaleMode = .aspectFit
	}
}

struct ChangeWeekdayView: View {
	
	@EnvironmentObject var gameState: GameState
	
	@AppStorage(UserDefaultsKeys.isSelectedSameDay) private var isSelectedSameDay: Bool = true
	@AppStorage(UserDefaultsKeys.isfirst) var isfirst: Bool = true
	
	@State private var showAlert = false
	@State private var tempSeletedWeekday: Weekday?
	@State private var showActionSheet = false
	
	var body: some View {
		HStack {
			Text("매주")
				.bold()
				.font(.body)
				.foregroundColor(.gray)
			Button(action: {
				self.showActionSheet = true
			}, label: {
				Text(gameState.selectedWeekday)
					.bold()
					.font(.body)
					.foregroundColor(!self.isfirst ? .blue : .gray)
					.padding(.trailing, -8.0)
				Image(systemName: "arrowtriangle.down.square.fill")
					.foregroundColor(!self.isfirst ? .blue : .gray)
			})
			.disabled(self.isfirst)
			.padding(.horizontal)
			.actionSheet(isPresented: $showActionSheet) {
				ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.allCases.map { weekday in
					if gameState.selectedWeekday == weekday.rawValue {
						return nil
					} else {
						return .default(Text(weekday.rawValue)) {
							self.showAlert = true
							self.tempSeletedWeekday = weekday
						}
					}
				}.compactMap { $0 } + [.cancel()])
			}
			// 요일 변경할건지 얼럿
			.alert(isPresented: $showAlert) {
				Alert(title: Text("매주 \(tempSeletedWeekday?.rawValue ?? "월요일")"), message: Text("선택한 요일로 변경할까요?"), primaryButton: .default(Text("네")) {
					// OK 버튼을 눌렀을 때 선택한 요일 업데이트
					gameState.selectedWeekday = self.tempSeletedWeekday?.rawValue ?? "월요일"
					let today = Weekday.allCases[(Calendar.current.component(.weekday, from: Date()) + 5) % 7].rawValue
					if today == tempSeletedWeekday?.rawValue ?? "월요일" {
						isSelectedSameDay = true
					}
					gameState.updateCanBreakBoxes()
				}, secondaryButton: .cancel(Text("아니요")))
			}.padding(.horizontal, -19.0)
			Text("에 칭찬 상자가 열려요")
				.bold()
				.font(.body)
				.foregroundColor(.gray)
			
			Spacer()
			
			//MARK: 아카이브 페이지 링크
			NavigationLink(destination: ArchivingView()) {
				Image(systemName: "archivebox")
					.resizable()
					.frame(width: 22, height: 22)
					.foregroundColor(.black)
			}
		}
		.padding(.horizontal, 20.0)
		.padding(.vertical, 10.0)
	}
}

struct MainView_Previews: PreviewProvider {
	static var previews: some View {
		MainView()
	}
}
