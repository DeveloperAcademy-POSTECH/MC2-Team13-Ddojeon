//
//  InfoPopupViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import SwiftUI

final class InfoPopupViewModel: ObservableObject {
    @Published var showWeekdaySheet = false
    
    private let userRepository: UserRepository
    private let dateManager: DateCalculable

    init(dateManager: DateCalculable = DateManager(),
         userRepository: UserRepository = .shared) {
        self.dateManager = dateManager
        self.userRepository = userRepository
    }
    
    func firstComplimentDone() {
        userRepository.isfirst = true
    }
    
    func toggleShowWeekdaySheet() {
        showWeekdaySheet.toggle()
    }
    
    func updateSelectedWeekday(_ weekdayString: String) {
        userRepository.selectedWeekday = weekdayString
        userRepository.selectedWeekdayTimeInterval = dateManager.nextWeekdayDate(userRepository.selectedWeekday)
    }
}
