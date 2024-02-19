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
