//
//  UserRepositoryProtocol.swift
//  Chinggu
//
//  Created by Junyoo on 2/29/24.
//

import Foundation

protocol UserRepositoryProtocol {
    var hasOnboarded: Bool { get set }
    var isSelectedSameDay: Bool { get set }
    var canBreakBoxes: Bool { get set }
    var isCompliment: Bool { get set }
    var isfirst: Bool { get set }
    var groupOrder: Int { get set }
    var lastResetTimeInterval: TimeInterval { get set }
    var selectedWeekdayTimeInterval: TimeInterval { get set }
    var selectedWeekday: String { get set }
}
