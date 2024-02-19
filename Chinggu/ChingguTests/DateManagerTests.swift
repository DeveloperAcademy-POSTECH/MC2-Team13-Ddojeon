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
        let calendar = Calendar.current
        let nextWeekdayDate1 = Date(timeIntervalSince1970: sut.nextWeekdayDate("월요일"))
        let nextWeekdayDate2 = sut.NEWnextWeekdayDate("월요일")
        
        let nextMonday1 = calendar.dateComponents([.weekday], from: nextWeekdayDate1)
        let nextMonday2 = calendar.dateComponents([.weekday], from: nextWeekdayDate2)
        
        print(nextWeekdayDate1, nextWeekdayDate2)
        //before: 2024-02-25 15:00:00 +0000 2024-02-25 18:46:01 +0000
        //after: 2024-02-25 15:00:00 +0000 2024-02-26 00:00:00 +0000
        //한국은 GMT +9 이므로 9시간 더하면 값이 동일함, 테스트 통과

        XCTAssertEqual(nextMonday1, nextMonday2)
    }
}
