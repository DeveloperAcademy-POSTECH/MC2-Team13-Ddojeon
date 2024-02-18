//
//  MainViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import SwiftUI

final class MainViewModel: ObservableObject {
    @Published var scene = GameScene()
    @Published var complimentsInGroupCount: Int = 0
    @Published var showActionSheet: Bool = false
    @Published var showAlert: Bool = false
    @Published var showBreakAlert: Bool = false
    @Published var tempSeletedWeekday: Weekday = .monday
    @Published var shake = 0.0

    @AppStorage("canBreakBoxes") var canBreakBoxes = false
    @AppStorage("lastResetTimeInterval") var lastResetTimeInterval: TimeInterval = Date().timeIntervalSinceNow
    @AppStorage("selectedWeekdayTimeInterval") var selectedWeekdayTimeInterval: TimeInterval = Date().addingTimeInterval(TimeInterval(7 * 24 * 60 * 60)).timeIntervalSince1970
    @AppStorage("isCompliment") var isCompliment: Bool = false
    @AppStorage("selectedWeekday") var selectedWeekday: String = Weekday.today.rawValue
    @AppStorage("isfirst") var isfirst: Bool = true
    @AppStorage("group") var groupOrder: Int = 1 {
        didSet {
            updateComplimentsGroupCount()
        }
    }
    
    let dataController: ComplimentDataController
    
    init(dataController: ComplimentDataController = CoreDataManager.shared) {
        self.dataController = dataController
    }
    
    var weekdayActionButtons: [ActionSheet.Button] {
        var buttons = Weekday.allCases.map { weekday -> ActionSheet.Button? in
            if selectedWeekday == weekday.rawValue {
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
        selectedWeekday = tempSeletedWeekday.rawValue
        selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
        updateCanBreakBoxes()
    }
    
    func updateComplimentsGroupCount() {
        complimentsInGroupCount = dataController.fetchComplimentsInGroup(Int16(groupOrder)).count
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
        scene.resetCompliment()
        scene.complimentCount = 0
        selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
    }
    
    // 초기화 날짜 비교 및 버튼 초기화
    func compareDates() {
        let calendar = Calendar.current
        let lastResetDate = Date(timeIntervalSince1970: lastResetTimeInterval)
        if !calendar.isDateInToday(lastResetDate) {
            isCompliment = false
            lastResetTimeInterval = Date().timeIntervalSince1970
        }
    }
    
    // 요일이 변경 될 때마다 현재 요일과 비교
    // 현재 날짜와 nextWeekdayDate와 비교
    func updateCanBreakBoxes() {
        let today = Date().timeIntervalSince1970
        if today >= selectedWeekdayTimeInterval {
            canBreakBoxes = true
            if scene.complimentCount > 0 {
                shake = 5
            }
        } else {
            canBreakBoxes = false
        }
    }
    
    func nextWeekdayDate(_ weekdayString: String) -> TimeInterval {
        let calendar = Calendar.current
        let weekdays = Weekday.allCases
        
        let selectedWeekday = weekdays.first(where: { $0.rawValue == weekdayString }) ?? .monday
        let today = calendar.startOfDay(for: Date())
        var nextDate = today
        for dayOffset in 1...7 {
            nextDate = today.addingTimeInterval(TimeInterval(dayOffset * 24 * 60 * 60))
            if calendar.component(.weekday, from: nextDate) == selectedWeekday.weekdayValue {
                break
            }
        }
        return nextDate.timeIntervalSince1970
    }
    
    func prepareScene(width: CGFloat, height: CGFloat) {
        if complimentsInGroupCount > scene.complimentCount {
            let boxPosition = CGPoint(x: scene.size.width / 2, y: scene.size.height - 50)
            scene.addCompliment(at: boxPosition)
            if canBreakBoxes {
                shake = 4
            }
        }
        
        scene.size = CGSize(width: width, height: height)
        scene.complimentCount = complimentsInGroupCount
        
        let currentDate = Date().timeIntervalSince1970
        if currentDate >= selectedWeekdayTimeInterval && complimentsInGroupCount == 0 {
            selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
        }
        compareDates()
        updateCanBreakBoxes()
        scene.scaleMode = .aspectFit
    }
}
