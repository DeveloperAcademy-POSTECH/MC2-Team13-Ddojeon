//
//  ComplimentBoxTests.swift
//  ChingguTests
//
//  Created by Junyoo on 2/18/24.
//

import XCTest
@testable import Chinggu

final class ComplimentBoxTests: XCTestCase {
    var sut: MockComplimentBoxController!

    override func setUpWithError() throws {
        sut = MockComplimentBoxController()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testAddCompliment() {
        let initialCount = sut.complimentCount
        let position = CGPoint(x: 100, y: 100)
        
        sut.addCompliment(at: position)
        
        XCTAssertEqual(sut.complimentCount, initialCount + 1, "well add done")
    }

    func testResetBoxes() {
        let position = CGPoint(x: 100, y: 100)
        sut.addCompliment(at: position)
        sut.addCompliment(at: position)
        sut.addCompliment(at: position)

        sut.resetCompliment()
        
        XCTAssertEqual(sut.complimentCount, 0, "well reset done")
    }
}
