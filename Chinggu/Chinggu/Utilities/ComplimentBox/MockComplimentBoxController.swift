//
//  MockComplimentBoxController.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import Foundation

class MockComplimentBoxController: ComplimentBoxController {
    private(set) var addedBoxes: [CGPoint] = []
    private(set) var resetCalled = false

    var complimentCount: Int {
        get { addedBoxes.count }
        set { }
    }

    func addCompliment(at position: CGPoint) {
        addedBoxes.append(position)
    }

    func resetCompliment() {
        addedBoxes.removeAll()
        resetCalled = true
    }
}
