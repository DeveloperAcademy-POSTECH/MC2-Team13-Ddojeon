//
//  ArchivingDetailViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import Foundation

final class ArchivingDetailViewModel: ObservableObject, DataErrorHandler {
    @Published var compliment: ComplimentEntity?
    @Published var complimentOrder: Int16
    @Published var errorDescription: String = ""
    @Published var showErrorAlert: Bool = false
    
    private var dataController: ComplimentDataController
    private var allComplimentsCount: Int16 = 0
    
    init(compliment: ComplimentEntity,
         dataController: ComplimentDataController = CoreDataManager.shared) {
        self.dataController = dataController
        self.compliment = compliment
        self.complimentOrder = compliment.order
        loadComplimentsCount()
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
        do {
            self.compliment = try dataController.fetchCompliment(order: complimentOrder)
        } catch {
            handleError(error)
        }
    }
    
    private func loadComplimentsCount() {
        do {
            self.allComplimentsCount = try dataController.fetchLatestOrder()
        } catch {
            handleError(error)
        }
    }
}
