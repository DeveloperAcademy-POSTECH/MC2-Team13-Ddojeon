//
//  ComplimentDataController.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import Foundation

protocol ComplimentDataController {
    func addCompliment(complimentText: String, groupID: Int16)
    func deleteCompliment(compliment: ComplimentEntity)
    func fetchAllCompliments() -> [ComplimentEntity]
    func fetchComplimentsInGroup(_ groupID: Int16) -> [ComplimentEntity]
    func fetchCompliment(order: Int16) -> ComplimentEntity?
    func fetchComplimentsCount() -> Int16
    func fetchLatestOrder() -> Int16
}
