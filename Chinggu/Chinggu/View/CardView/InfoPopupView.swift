//
//  InfoCardView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/15.
//

import SwiftUI

struct InfoPopupView: View {
    @Binding var showInfoPopup: Bool
    @AppStorage("isfirst") var isfirst: Bool = false
    @State private var showWeekdaySheet = false
    @AppStorage("selectedWeekday") private var selectedWeekday: String = Weekday.allCases[(Calendar.current.component(.weekday, from: Date()) + 5) % 7].rawValue
    @AppStorage("selectedWeekdayTimeInterval") private var selectedWeekdayTimeInterval: TimeInterval = Date().timeIntervalSince1970
    var body: some View {
        ZStack {
            LottieView(filename: "cardBeforeAnimation", loopState: false, contentMode: .scaleAspectFill)
				.ignoresSafeArea()
				.transaction { transaction in
					transaction.animation = nil
				}
				.opacity(showInfoPopup ? 1 : 0)
			
			Image("popup")
				.shadow(color: Color.black.opacity(0.2), radius: 7, x: 1, y: 6)
				.overlay {
					VStack {
						Text("축하해요\n첫 칭찬을 완료했어요")
							.font(.title)
							.bold()
							.multilineTextAlignment(.center)
							.lineSpacing(5)
							.padding(.bottom, 12)
						
						Text("하루 단 한 번, 나를 위해 기록해보세요.\n저장된 칭찬은 내가 설정한 요일에\n해제할 수 있어요. (주 1회)")
							.font(.body)
							.multilineTextAlignment(.center)
							.foregroundColor(Color.black.opacity(0.7))
							.lineSpacing(3)
												
						Button(action: {
                showWeekdaySheet = true
						}) {
							Text("요일 설정")
								.font(.title3)
                .bold()
								.foregroundColor(.white)
								.kerning(1)
								.padding(.vertical,6)
								.frame(width: 310, height: 56)
						}
            .actionSheet(isPresented: $showWeekdaySheet) {
              ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.allCases.map { weekday in
                 return .default(Text(weekday.rawValue)) {
                   selectedWeekday = weekday.rawValue
                   selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
                   withAnimation(.easeOut(duration: 0.5)) {
                     showInfoPopup = false
                     isfirst = false
                   }
                 }
              }.compactMap { $0 } + [.cancel()])
            }
						.offset(y: 40)
						.background {
							RoundedRectangle(cornerRadius: 10)
								.foregroundColor(.black)
								.offset(y: 40)
						}
					}
				}
		}
	}
    
    func nextWeekdayDate(_ weekdayString: String) -> TimeInterval {
        let calendar = Calendar.current
        let weekdays = Weekday.allCases
        
        let selectedWeekday = weekdays.first(where: { $0.rawValue == weekdayString }) ?? .monday
        let today = calendar.startOfDay(for: Date())
        var nextDate = today
        for dayOffset in 1...7 {
            nextDate = today.addingTimeInterval(TimeInterval(dayOffset * 24 * 60 * 60))
            if calendar.component(.weekday, from: nextDate) == selectedWeekday.weekdayValue {
                break
            }
        }
        return nextDate.timeIntervalSince1970
    }
}

struct InfoPopupView_Previews: PreviewProvider {
	static var previews: some View {
		InfoPopupView(showInfoPopup: .constant(true))
	}
}
