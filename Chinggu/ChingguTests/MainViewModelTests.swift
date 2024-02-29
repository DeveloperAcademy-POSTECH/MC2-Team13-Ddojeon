//
//  MainViewModelTests.swift
//  ChingguTests
//
//  Created by Junyoo on 2/29/24.
//

import XCTest
@testable import Chinggu

@MainActor
final class MainViewModelTests: XCTestCase {
    var viewModel: MockMainViewModel!
    
    let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())

    override func setUpWithError() throws {
        try super.setUpWithError()
        
        viewModel = MockMainViewModel(dataController: CoreDataManager(inMemory: true),
                                      dateManager: DateManager(),
                                      userRepository: MockUserRepository())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        
        try super.tearDownWithError()
    }

    func testApplyWeekdayChange() throws {
        let nextWeekDay = viewModel.dateManager.nextWeekdayDate(Weekday.monday.rawValue)
        viewModel.tempSeletedWeekday = .monday
                
        viewModel.applyWeekdayChange()
        
        XCTAssertEqual(viewModel.userRepository.selectedWeekday, viewModel.tempSeletedWeekday.rawValue)
        XCTAssertEqual(viewModel.userRepository.selectedWeekdayTimeInterval, nextWeekDay)
    }
    
    func testUpdateComplimentsGroupCount() throws {
        try viewModel.dataController.addCompliment(complimentText: "test", groupID: 1)
        try viewModel.dataController.addCompliment(complimentText: "test", groupID: 1)
        try viewModel.dataController.addCompliment(complimentText: "test", groupID: 1)
        
        viewModel.updateComplimentsGroupCount()
        
        XCTAssertEqual(viewModel.complimentsInGroupCount, 3)
    }
    
    func testopenComplimentBox() throws {
        viewModel.complimentBox.addCompliment(at: CGPoint(x: 1, y: 1))
        let initTime = viewModel.userRepository.selectedWeekdayTimeInterval
        
        viewModel.openComplimentBox()
        
        XCTAssertEqual(viewModel.complimentBox.complimentCount, 0)
        XCTAssertNotEqual(viewModel.userRepository.selectedWeekdayTimeInterval, initTime)
    }
    
    func testCompareDates() throws {
        viewModel.userRepository.lastResetTimeInterval = yesterday!.timeIntervalSince1970
        
        viewModel.compareDates()
        
        XCTAssertFalse(viewModel.userRepository.isCompliment)
        XCTAssertNotEqual(viewModel.userRepository.lastResetTimeInterval, yesterday!.timeIntervalSince1970)
    }
    
    func testUpdateCanBreakBoxes() {
        viewModel.userRepository.selectedWeekdayTimeInterval = yesterday!.timeIntervalSince1970
        viewModel.complimentBox.complimentCount = 1
        
        viewModel.updateCanBreakBoxes()
        
        XCTAssertTrue(viewModel.userRepository.canBreakBoxes)
        XCTAssertEqual(viewModel.shake, 5)
    }
}

