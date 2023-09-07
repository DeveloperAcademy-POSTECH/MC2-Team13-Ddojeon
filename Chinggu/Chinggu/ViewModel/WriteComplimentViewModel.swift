//
//  WriteComplimentViewModel.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import SwiftUI

class WriteComplimentViewModel: ObservableObject {
    @Published var categories: [Category] = Categories.allCases.map { Category(title: $0.title,
                                                                               example: $0.example)}
    @Published var writingContent = ""
    @AppStorage("isCompliment") private var isCompliment = false
    @AppStorage("group") var groupOrder: Int = 1

    func saveCompliment() {
        PersistenceController.shared.addCompliment(complimentText: writingContent, groupID: Int16(groupOrder))
        isCompliment = true
    }
}
