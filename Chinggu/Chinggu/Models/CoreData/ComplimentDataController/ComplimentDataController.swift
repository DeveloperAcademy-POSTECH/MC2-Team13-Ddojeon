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
    func fetchCompliments(request: FetchRequestType) throws -> [ComplimentEntity]
    func fetchLatestOrder() throws -> Int16
}
