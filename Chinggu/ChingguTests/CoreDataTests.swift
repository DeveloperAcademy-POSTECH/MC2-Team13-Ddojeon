//
//  CoreDataTests.swift
//  ChingguTests
//
//  Created by Junyoo on 2/16/24.
//

import XCTest
@testable import Chinggu

final class CoreDataTests: XCTestCase {
    
    var sut: CoreDataManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CoreDataManager(inMemory: true)
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testAddCompliment() throws {
        let initCount = try! sut.fetchComplimentsInGroup(1).count
        
        try! sut.addCompliment(complimentText: "칭찬행", groupID: 1)
        
        let newCount = try! sut.fetchComplimentsInGroup(1).count
        XCTAssertEqual(newCount, initCount + 1)
    }
    
    func testFetchComplimentsIngroup() throws {
        try! sut.addCompliment(complimentText: "칭찬", groupID: 3)
        
        let groupCompliments = try! sut.fetchComplimentsInGroup(3)
        
        XCTAssertNotEqual(groupCompliments.count, 0)
    }
}
