//
//  MockMainViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/28/24.
//

import SwiftUI

final class MockMainViewModel: ObservableObject, DataErrorHandler {
    var complimentBox = ComplimentBox()
    var complimentsInGroupCount: Int = 0
    var showActionSheet: Bool = false
    var showAlert: Bool = false
    var showBreakAlert: Bool = false
    var tempSeletedWeekday: Weekday = .monday
    var shake = 0.0
    var errorDescription: String = ""
    var showErrorAlert: Bool = false

    var userRepository: UserRepositoryProtocol
    let dataController: ComplimentDataController
    let dateManager: DateCalculable
    
    var weekdayActionButtons: [ActionSheet.Button] {
        var buttons = Weekday.allCases.map { weekday -> ActionSheet.Button? in
            if userRepository.selectedWeekday == weekday.rawValue {
                return nil
            } else {
                return .default(Text(weekday.rawValue)) {
                    self.tempSeletedWeekday = weekday
                    self.showAlert = true
                }
            }
        }.compactMap { $0 }
        buttons.append(.cancel())
        return buttons
    }
    
    init(dataController: ComplimentDataController = CoreDataManager(inMemory: true),
         dateManager: DateCalculable = DateManager(),
         userRepository: UserRepositoryProtocol = MockUserRepository()) {
        self.userRepository = userRepository
        self.dataController = dataController
        self.dateManager = dateManager
        self.userRepository = userRepository
    }

    //ok
    func applyWeekdayChange() {
        userRepository.selectedWeekday = tempSeletedWeekday.rawValue
        userRepository.selectedWeekdayTimeInterval = dateManager.nextWeekdayDate(userRepository.selectedWeekday)
        
        updateCanBreakBoxes()
    }
    
    //ok
    func updateComplimentsGroupCount() {
        do {
            complimentsInGroupCount = try dataController.fetchCompliments(request: .inGroup(Int16(userRepository.groupOrder))).count
        } catch {
            handleError(error)
        }
    }
    
    //ok
    func openComplimentBox() {
        complimentBox.resetCompliment()
        complimentBox.complimentCount = 0
        userRepository.selectedWeekdayTimeInterval = dateManager.nextWeekdayDate(userRepository.selectedWeekday)
    }
    
    //
    func compareDates() {
        let calendar = Calendar.current
        let lastResetDate = Date(timeIntervalSince1970: userRepository.lastResetTimeInterval)
        if !calendar.isDateInToday(lastResetDate) {
            userRepository.isCompliment = false
            userRepository.lastResetTimeInterval = Date().timeIntervalSince1970
        }
    }
    
    //
    func updateCanBreakBoxes() {
        let today = Date().timeIntervalSince1970
        if today >= userRepository.selectedWeekdayTimeInterval {
            userRepository.canBreakBoxes = true
            if complimentBox.complimentCount > 0 {
                shake = 5
            }
        } else {
            userRepository.canBreakBoxes = false
        }
    }
    
    func prepareScene(width: CGFloat, height: CGFloat) {
        tempSeletedWeekday = Weekday(rawValue: userRepository.selectedWeekday) ?? .monday
        
        if complimentsInGroupCount > complimentBox.complimentCount {
            let boxPosition = CGPoint(x: complimentBox.size.width / 2, y: complimentBox.size.height - 50)
            complimentBox.addCompliment(at: boxPosition)
            if userRepository.canBreakBoxes {
                shake = 4
            }
        }
        
        complimentBox.size = CGSize(width: width, height: height)
        complimentBox.complimentCount = complimentsInGroupCount
        
        let currentDate = Date().timeIntervalSince1970
        if currentDate >= userRepository.selectedWeekdayTimeInterval && complimentsInGroupCount == 0 {
            userRepository.selectedWeekdayTimeInterval = dateManager.nextWeekdayDate(userRepository.selectedWeekday)
        }
        compareDates()
        updateCanBreakBoxes()
        complimentBox.scaleMode = .aspectFit
    }
    
    func toggleShowActionSheet() {
        showActionSheet.toggle()
    }
    
    func toggleShowAlert() {
        showAlert.toggle()
    }
    
    func toggleShowBreakAlert() {
        showBreakAlert.toggle()
    }
}
