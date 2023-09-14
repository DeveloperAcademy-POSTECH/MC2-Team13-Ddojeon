//
//  ArchivingViewModel.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/14.
//

import SwiftUI

class ArchivingViewModel: ObservableObject {
    @FetchRequest(
        entity: ComplimentEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
    ) var compliments: FetchedResults<ComplimentEntity>
    @AppStorage("group") var groupOrder: Int = 1
    @Published var totalOrder = 1

    func goBack() {
    }

    func goNext(){
    }

    func deleteCompliment(indexset: IndexSet) {
        guard let index = indexset.first else { return }
        let selectedEntity = compliments[index]
        PersistenceController.shared.deleteCompliment(compliment: selectedEntity)
    }
}
