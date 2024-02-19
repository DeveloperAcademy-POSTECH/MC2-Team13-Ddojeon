//
//  UserRepository.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import SwiftUI

class UserRepository {
    static let shared = UserRepository()

    @AppStorage(AppStorageKeys.hasOnboarded) var hasOnboarded: Bool = false
    @AppStorage(AppStorageKeys.isSelectedSameDay) var isSelectedSameDay: Bool = true
    @AppStorage(AppStorageKeys.canBreakBoxes) var canBreakBoxes = false
    @AppStorage(AppStorageKeys.lastResetTimeInterval) var lastResetTimeInterval: TimeInterval = Date().timeIntervalSinceNow
    @AppStorage(AppStorageKeys.selectedWeekdayTimeInterval) var selectedWeekdayTimeInterval: TimeInterval = Date().addingTimeInterval(TimeInterval(7 * 24 * 60 * 60)).timeIntervalSince1970
    @AppStorage(AppStorageKeys.isCompliment) var isCompliment: Bool = false
    @AppStorage(AppStorageKeys.selectedWeekday) var selectedWeekday: String = Weekday.today.rawValue
    @AppStorage(AppStorageKeys.isfirst) var isfirst: Bool = true
    @AppStorage(AppStorageKeys.groupOrder) var groupOrder: Int = 1
}
