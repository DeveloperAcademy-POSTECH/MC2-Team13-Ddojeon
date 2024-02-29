//
//  MockUserRepository.swift
//  Chinggu
//
//  Created by Junyoo on 2/29/24.
//

import Foundation

class MockUserRepository: UserRepositoryProtocol {
    var hasOnboarded: Bool = false
    var isSelectedSameDay: Bool = true
    var canBreakBoxes: Bool = false
    var isCompliment: Bool = false
    var isfirst: Bool = true
    var groupOrder: Int = 1
    var lastResetTimeInterval: TimeInterval = Date().timeIntervalSince1970
    var selectedWeekdayTimeInterval: TimeInterval = Date().addingTimeInterval(TimeInterval(7 * 24 * 60 * 60)).timeIntervalSince1970
    var selectedWeekday: String = Weekday.today.rawValue
}
