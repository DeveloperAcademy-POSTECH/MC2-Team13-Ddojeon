//
//  CardFullScreenViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import SwiftUI

final class CardFullScreenViewModel: ObservableObject {
    @Published var complimentsInGroup: [ComplimentEntity] = []
    @Published var groupOrderText: String = ""
    @Published var groupStartEndDates: String = ""
    @Published var randomQuote: Quote
    
    private let dataController: ComplimentDataController
    private let userRepository: UserRepository

    init(dataController: ComplimentDataController = CoreDataManager.shared,
         userRepository: UserRepository = .shared) {
        self.dataController = dataController
        self.randomQuote = Quote.Quotes.randomElement() ?? Quote(text: "한주간 고생했어요!", speaker: "칭구")
        self.userRepository = userRepository
        fetchWeeklyCompliment()
    }
    
    func fetchWeeklyCompliment() {
        complimentsInGroup = dataController.fetchComplimentsInGroup(Int16(userRepository.groupOrder))
        if let minDate = complimentsInGroup.first?.createDate,
           let maxDate = complimentsInGroup.last?.createDate {
            let start = minDate.formatWithDot()
            let end = maxDate.formatWithDot()
            groupStartEndDates = "\(start) ~ \(end)"
            groupOrderText = "\(userRepository.groupOrder)번째 상자"
        }
    }
        
    func breakComplimentBox() {
        userRepository.groupOrder += 1
        userRepository.isSelectedSameDay = true
        userRepository.canBreakBoxes = false
    }
}
