//
//  ArchivingViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import SwiftUI
import CoreData

final class ArchivingViewModel: ObservableObject, DataErrorHandler {
    @Published var compliments: [ComplimentEntity] = []
    @Published var errorDescription: String = ""
    @Published var showErrorAlert: Bool = false
    
    private let dataController: ComplimentDataController
    let userRepository: UserRepository

    init(dataController: ComplimentDataController = CoreDataManager.shared,
         userRepository: UserRepository = .shared) {
        self.dataController = dataController
        self.userRepository = userRepository
        fetchCompliments()
    }

    func fetchCompliments() {
        do {
            compliments = try dataController.fetchCompliments(request: .all)
        } catch {
            handleError(error)
        }
    }

    func deleteCompliments(at offsets: IndexSet) {
        offsets.forEach { index in
            let compliment = compliments[index]
            do {
                try dataController.deleteCompliment(compliment: compliment)
                fetchCompliments()
            } catch {
                handleError(error)
            }
        }
        fetchCompliments()
    }
    
    func filterComplimentsInGroup(by groupID: Int) -> [ComplimentEntity] {
        return compliments.filter { $0.groupID == groupID }
    }
}
