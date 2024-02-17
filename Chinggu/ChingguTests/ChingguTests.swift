//
//  ChingguTests.swift
//  ChingguTests
//
//  Created by Junyoo on 2/16/24.
//

import XCTest
import CoreData
@testable import Chinggu

final class ChingguTests: XCTestCase {
    
    var coredataManager: CoreDataManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        coredataManager = CoreDataManager(inMemory: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        coredataManager = nil
        try super.tearDownWithError()
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testAddCompliment() throws {
        let initCount = coredataManager.fetchComplimentsInGroup(1).count
        coredataManager.addCompliment(complimentText: "칭찬행", groupID: 1)
        
        let newCount = coredataManager.fetchComplimentsInGroup(1).count
        XCTAssertEqual(newCount, initCount + 1, "칭찬 1개 추가 테스트 성공")
    }
    
    func testFetchLatestOrder() throws {
        coredataManager.addCompliment(complimentText: "칭찬", groupID: 1)
        let latestOrder = coredataManager.fetchLatestOrder()
        
        XCTAssertEqual(latestOrder, 1, "한개추가했고, 마지막 order가 1이면 성공")
    }
    
    func testFetchComplimentsIngroup() throws {
        coredataManager.addCompliment(complimentText: "칭찬", groupID: 3)
        let groupCompliments = coredataManager.fetchComplimentsInGroup(3)
        XCTAssertNotEqual(groupCompliments.count, 0, "칭찬했고, 0개 아니면 성공")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
