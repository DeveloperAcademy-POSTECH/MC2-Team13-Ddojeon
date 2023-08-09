//
//  HomeViewTop.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/10.
//

import SwiftUI

struct HomeViewTop: View {
	
	@State private var showActionSheet = false
	@State private var showAlert = false
	@State private var tempSeletedWeekday: Weekday?

	@AppStorage("selectedWeekday") private var selectedWeekday: String = Weekday.today.rawValue
	@AppStorage("canBreakBoxes") private var canBreakBoxes = false
	@AppStorage("isfirst") var isfirst: Bool = true

    var body: some View {
		HStack {
			Text("매주")
				.bold()
				.font(.body)
				.foregroundColor(.gray)
			Button {
				self.showActionSheet = true
			} label: {
				Text(selectedWeekday)
					.bold()
					.font(.body)
					.foregroundColor(!isfirst ? .blue : .gray)
					.padding(.trailing, -8.0)
				Image(systemName: "arrowtriangle.down.square.fill")
					.foregroundColor(!isfirst ? .blue : .gray)
			}
			.disabled(isfirst)
			.padding(.horizontal)
			.actionSheet(isPresented: $showActionSheet) {
				ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.allCases.map { weekday in
					if selectedWeekday == weekday.rawValue {
						return nil
					} else {
						return .default(Text(weekday.rawValue)) {
							self.showAlert = true
							self.tempSeletedWeekday = weekday
						}
					}
				}.compactMap { $0 } + [.cancel()])
			}
			.alert(isPresented: $showAlert) {
				Alert(title: Text("매주 \(tempSeletedWeekday?.rawValue ?? "월요일")"), message: Text("선택한 요일로 변경할까요?"), primaryButton: .default(Text("네")) {
					// OK 버튼을 눌렀을 때 선택한 요일 업데이트
					self.selectedWeekday = self.tempSeletedWeekday?.rawValue ?? "월요일"
				}, secondaryButton: .cancel(Text("아니요")))
			}
			.padding(.horizontal, -19.0)
			
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
		.padding()
    }
}

struct HomeViewTop_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewTop()
    }
}
