//
//  ComplimentViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import Foundation

class ComplimentViewModel: Identifiable {
    let id: UUID
    var compliment: String
    var groupID: Int16
    var order: Int16
    var createDate: Date

    init(entity: ComplimentEntity) {
        self.id = entity.id ?? UUID()
        self.compliment = entity.compliment ?? ""
        self.groupID = entity.groupID
        self.order = entity.order
        self.createDate = entity.createDate ?? Date()
    }
}
