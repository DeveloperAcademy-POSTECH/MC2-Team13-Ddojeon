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
    
    init(compliment: ComplimentEntity) {
        self.compliment = compliment
        self.complimentOrder = compliment.order
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
    
    func isButtonDisabled(direction: TowardsButtonDirection) -> Bool {
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
