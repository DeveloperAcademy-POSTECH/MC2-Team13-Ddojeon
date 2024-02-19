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
    //테스트 완료했으나 AppStorage에서 Date값을 지원하지 않는다는걸 뒤늦게 발견..
    func NEWnextWeekdayDate(_ weekdayString: String) -> Date {
        //Timezone GMT0으로 설정하고, 오늘 자정을 기준으로 계산하기
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(secondsFromGMT: 0)!
        let todayJajung = calendar.startOfDay(for: Date())
        guard let weekday = Weekday(rawValue: weekdayString)?.weekdayValue else { return Date() }
        
        var nextDate = Date()
        for dayOffset in 1...7 {
            if let date = calendar.date(byAdding: .day, value: dayOffset, to: todayJajung),
               calendar.component(.weekday, from: date) == weekday {
                nextDate = date
                break
            }
        }
        return nextDate
    }
}
