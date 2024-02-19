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
    
    private let dataController: ComplimentDataController
    private let userRepository: UserRepository
    
    init(dataController: ComplimentDataController = CoreDataManager.shared,
         userRepository: UserRepository = .shared) {
        self.dataController = dataController
        self.userRepository = userRepository
    }

    func saveCompliment() {
        dataController.addCompliment(complimentText: writingContent, groupID: Int16(userRepository.groupOrder))
        userRepository.isCompliment = true
    }
}
