//
//  CardFullScreenViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import SwiftUI

final class CardFullScreenViewModel: ObservableObject {
    @AppStorage("group") var groupOrder: Int = 1
    @AppStorage("isSelectedSameDay") private var isSelectedSameDay: Bool = true
    @AppStorage("canBreakBoxes") private var canBreakBoxes = false

    @Published var complimentsInGroup: [ComplimentEntity] = []
    @Published var groupOrderText: String = ""
    @Published var groupStartEndDates: String = ""
    @Published var randomQuote: Quote
    
    init() {
        self.randomQuote = Quote.Quotes.randomElement() ?? Quote(text: "한주간 고생했어요!", speaker: "칭구")
    }
    
    func fetchWeeklyCompliment() {
        complimentsInGroup = CoreDataManager.shared.fetchComplimentsInGroup(Int16(groupOrder))
        if let minDate = complimentsInGroup.first?.createDate,
           let maxDate = complimentsInGroup.last?.createDate {
            let start = minDate.formatWithDot()
            let end = maxDate.formatWithDot()
            groupStartEndDates = "\(start) ~ \(end)"
            groupOrderText = "\(groupOrder)번째 상자"
        }
    }
        
    func breakComplimentBox() {
        groupOrder += 1
        isSelectedSameDay = true
        canBreakBoxes = false
    }
}
