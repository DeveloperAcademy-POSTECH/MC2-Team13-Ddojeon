//
//  InfoPopupViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import SwiftUI

final class InfoPopupViewModel: ObservableObject {
    @Published var showWeekdaySheet = false
    @AppStorage("isfirst") var isfirst: Bool = false
    @AppStorage("selectedWeekday") var selectedWeekday: String = Weekday.allCases[(Calendar.current.component(.weekday, from: Date()) + 5) % 7].rawValue
    @AppStorage("selectedWeekdayTimeInterval") var selectedWeekdayTimeInterval: TimeInterval = Date().timeIntervalSince1970

    
    func firstComplimentDone() {
        isfirst = true
    }
    
    func toggleShowWeekdaySheet() {
        showWeekdaySheet.toggle()
    }
    
    func updateSelectedWeekday(_ weekdayString: String) {
        selectedWeekday = weekdayString
        selectedWeekdayTimeInterval = nextWeekdayDate(weekdayString)
    }
    
    private func nextWeekdayDate(_ weekdayString: String) -> TimeInterval {
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
