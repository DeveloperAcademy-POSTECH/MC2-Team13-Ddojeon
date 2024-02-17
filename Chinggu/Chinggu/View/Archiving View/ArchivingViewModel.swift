//
//  ArchivingViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import Foundation
import CoreData

final class ArchivingViewModel: ObservableObject {
    @Published var compliments: [ComplimentEntity] = []
    private var groupID: Int16 = 1

    init(groupID: Int16) {
        self.groupID = groupID
        fetchCompliments()
    }

    func fetchCompliments() {
        self.compliments = CoreDataManager.shared.fetchComplimentsInGroup(groupID)
    }

    func deleteCompliments(at offsets: IndexSet) {
        offsets.forEach { index in
            let compliment = compliments[index]
            CoreDataManager.shared.deleteCompliment(compliment: compliment)
        }
        fetchCompliments()
    }
}
