//
//  ComplimentDataController.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import Foundation

protocol ComplimentDataController {
    func addCompliment(complimentText: String, groupID: Int16) throws
    func deleteCompliment(compliment: ComplimentEntity) throws
    func fetchAllCompliments() throws -> [ComplimentEntity]
    func fetchComplimentsInGroup(_ groupID: Int16) throws -> [ComplimentEntity]
    func fetchCompliment(order: Int16) throws -> ComplimentEntity?
    func fetchComplimentsCount() throws -> Int16
    func fetchLatestOrder() throws -> Int16
}
