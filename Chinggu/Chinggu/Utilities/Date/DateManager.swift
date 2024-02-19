//
//  DateManager.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import Foundation

final class DateManager: DateCalculable {
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
    
    //MARK: TimeInterval값 너무 복잡한것같아서 day값을 더한것으로 바꾸려 하는데 기존거 잘 돌아가고, 혹시모르니 테스트해보고 나중에 바꾸기
    func nextWeekdayDateTest(from date: Date, weekdayString: String) -> Date {
        let calendar = Calendar.current
        guard let weekday = Weekday(rawValue: weekdayString)?.weekdayValue else { return date }
        
        var nextDate = date
        for dayOffset in 1...7 {
            nextDate = calendar.date(byAdding: .day, value: dayOffset, to: date)!
            if calendar.component(.weekday, from: nextDate) == weekday {
                break
            }
        }
        return nextDate
    }
}
