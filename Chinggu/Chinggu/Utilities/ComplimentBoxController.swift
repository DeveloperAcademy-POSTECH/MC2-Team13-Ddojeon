//
//  ComplimentBoxController.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import Foundation

protocol ComplimentBoxController {
    func addCompliment(at position: CGPoint)
    func resetCompliment()
    var complimentCount: Int { get set }
}

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
