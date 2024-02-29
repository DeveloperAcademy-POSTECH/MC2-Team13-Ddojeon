//
//  WriteComplimentViewModel.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import SwiftUI
import Combine

final class WriteComplimentViewModel: ObservableObject, DataErrorHandler {
    @Published var categories: [Category] = Categories.allCases.map { Category(title: $0.title,
                                                                               example: $0.example)}
    @Published var writingContent = ""
    @Published var showErrorAlert = false
    @Published var errorDescription = ""

    
    private let dataController: ComplimentDataController
    private let userRepository: UserRepository
    
    init(dataController: ComplimentDataController = CoreDataManager.shared,
         userRepository: UserRepository = .shared) {
        self.dataController = dataController
        self.userRepository = userRepository
    }

    func saveCompliment() {
        do {
            try dataController.addCompliment(complimentText: writingContent, groupID: Int16(userRepository.groupOrder))
            userRepository.isCompliment = true
        } catch {
            handleError(error)
        }
    }
    
    func errorTrigger() {
        do {
            try CoreDataManager.shared.addComplimentWithError(complimentText: writingContent, groupID: Int16(userRepository.groupOrder))
        } catch {
            handleError(error)
        }
    }
}
