//
//  ArchivingViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import SwiftUI
import CoreData

final class ArchivingViewModel: ObservableObject {
    @Published var compliments: [ComplimentEntity] = []
    
    private let dataController: ComplimentDataController
    let userRepository: UserRepository

    init(dataController: ComplimentDataController = CoreDataManager.shared,
         userRepository: UserRepository = .shared) {
        self.dataController = dataController
        self.userRepository = userRepository
        fetchCompliments()
    }

    func fetchCompliments() {
        self.compliments = dataController.fetchAllCompliments()
    }

    func deleteCompliments(at offsets: IndexSet) {
        offsets.forEach { index in
            let compliment = compliments[index]
            dataController.deleteCompliment(compliment: compliment)
        }
        fetchCompliments()
    }
    
    func filterComplimentsInGroup(by groupID: Int) -> [ComplimentEntity] {
        return compliments.filter { $0.groupID == groupID }
    }
}
