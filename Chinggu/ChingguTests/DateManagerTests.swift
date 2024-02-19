//
//  DateManagerTests.swift
//  ChingguTests
//
//  Created by Junyoo on 2/19/24.
//

import XCTest
@testable import Chinggu

final class DateManagerTests: XCTestCase {
    var sut: DateManager!

    override func setUpWithError() throws {
        sut = DateManager()
    }
    
    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testNextWeekdayDate() throws {
        let today = Calendar.current.startOfDay(for: Date())
        let nextMonday = Calendar.current.nextDate(after: today, matching: DateComponents(weekday: 2), matchingPolicy: .nextTime)!
        
        let nextMondayTimeInterval = sut.nextWeekdayDate("월요일")
        
        XCTAssertEqual(nextMonday.timeIntervalSince1970, nextMondayTimeInterval, accuracy: 1.0)
    }
}
