//
//  ArchivingViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import SwiftUI
import CoreData

final class ArchivingViewModel: ObservableObject {
    @AppStorage("group") var groupOrder: Int = 1
    @Published var compliments: [ComplimentEntity] = []
    
    let dataController: ComplimentDataController

    init(dataController: ComplimentDataController = CoreDataManager.shared) {
        self.dataController = dataController
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
