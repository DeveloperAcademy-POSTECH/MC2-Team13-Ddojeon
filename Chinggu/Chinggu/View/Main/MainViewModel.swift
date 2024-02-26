//
//  MainViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import SwiftUI

final class MainViewModel: ObservableObject, DataErrorHandler {
    @Published var complimentBox = ComplimentBox()
    @Published var complimentsInGroupCount: Int = 0
    @Published var showActionSheet: Bool = false
    @Published var showAlert: Bool = false
    @Published var showBreakAlert: Bool = false
    @Published var tempSeletedWeekday: Weekday = .monday
    @Published var shake = 0.0
    @Published var errorDescription: String = ""
    @Published var showErrorAlert: Bool = false

    private let dataController: ComplimentDataController
    private let dateManager: DateCalculable
    let userRepository: UserRepository
    
    init(dataController: ComplimentDataController = CoreDataManager.shared,
         dateManager: DateCalculable = DateManager(),
         userRepository: UserRepository = .shared) {
        self.dataController = dataController
        self.dateManager = dateManager
        self.userRepository = userRepository
    }
    
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
    
    func applyWeekdayChange() {
        userRepository.selectedWeekday = tempSeletedWeekday.rawValue
        userRepository.selectedWeekdayTimeInterval = dateManager.nextWeekdayDate(userRepository.selectedWeekday)
        
        updateCanBreakBoxes()
    }
    
    func updateComplimentsGroupCount() {
        do {
            complimentsInGroupCount = try dataController.fetchCompliments(request: .inGroup(Int16(userRepository.groupOrder))).count
        } catch {
            handleError(error)
        }
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
    
    func openComplimentBox() {
        complimentBox.resetCompliment()
        complimentBox.complimentCount = 0
        userRepository.selectedWeekdayTimeInterval = dateManager.nextWeekdayDate(userRepository.selectedWeekday)
    }
    
    // 초기화 날짜 비교 및 버튼 초기화
    func compareDates() {
        let calendar = Calendar.current
        let lastResetDate = Date(timeIntervalSince1970: userRepository.lastResetTimeInterval)
        if !calendar.isDateInToday(lastResetDate) {
            userRepository.isCompliment = false
            userRepository.lastResetTimeInterval = Date().timeIntervalSince1970
        }
    }
    
    // 요일이 변경 될 때마다 현재 요일과 비교
    // 현재 날짜와 nextWeekdayDate와 비교
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
}
