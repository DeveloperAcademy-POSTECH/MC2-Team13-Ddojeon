//
//  ComplimentEntity+CoreDataProperties.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/11.
//
//

import Foundation
import CoreData


extension ComplimentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ComplimentEntity> {
        return NSFetchRequest<ComplimentEntity>(entityName: "ComplimentEntity")
    }

    @NSManaged public var compliment: String?
    @NSManaged public var createDate: Date?
    @NSManaged public var group: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var order: Int16

}

extension ComplimentEntity : Identifiable {

}
