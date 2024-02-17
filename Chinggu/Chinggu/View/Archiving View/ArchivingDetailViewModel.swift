//
//  ArchivingDetailViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import Foundation

final class ArchivingDetailViewModel: ObservableObject {
    @Published var compliment: ComplimentEntity?
    @Published var complimentOrder: Int16
    private var allComplimentsCount: Int16 {
        CoreDataManager.shared.fetchComplimentsCount()
    }
    
    init(complimentOrder: Int16) {
        self.complimentOrder = complimentOrder
        loadCompliment()
    }
    
    
    func nextCompliment() {
        if complimentOrder < allComplimentsCount {
            complimentOrder += 1
            loadCompliment()
        }
    }
    
    func previousCompliment() {
        if complimentOrder > 1 {
            complimentOrder -= 1
            loadCompliment()
        }
    }
    
    func isButtonDisabled(direction: ButtonDirection) -> Bool {
        switch direction {
        case .forward:
            return complimentOrder >= allComplimentsCount
        case .backward:
            return complimentOrder <= 1
        }
    }
    
    func loadCompliment() {
        self.compliment = CoreDataManager.shared.fetchCompliment(order: complimentOrder)
    }
}


enum ButtonDirection {
    case forward
    case backward
}
