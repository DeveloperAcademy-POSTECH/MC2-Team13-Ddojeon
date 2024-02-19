//
//  CoreDataTests.swift
//  ChingguTests
//
//  Created by Junyoo on 2/16/24.
//

import XCTest
@testable import Chinggu

final class CoreDataTests: XCTestCase {
    
    var coredataManager: CoreDataManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        coredataManager = CoreDataManager(inMemory: true)
    }

    override func tearDownWithError() throws {
        coredataManager = nil
        try super.tearDownWithError()
    }

    func testAddCompliment() throws {
        let initCount = try! coredataManager.fetchComplimentsInGroup(1).count
        
        try! coredataManager.addCompliment(complimentText: "칭찬행", groupID: 1)
        
        let newCount = try! coredataManager.fetchComplimentsInGroup(1).count
        XCTAssertEqual(newCount, initCount + 1)
    }
    
    func testFetchComplimentsIngroup() throws {
        try! coredataManager.addCompliment(complimentText: "칭찬", groupID: 3)
        
        let groupCompliments = try! coredataManager.fetchComplimentsInGroup(3)
        
        XCTAssertNotEqual(groupCompliments.count, 0)
    }
}
