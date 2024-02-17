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
    @NSManaged public var groupID: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var order: Int16
    
    public var unwrappedCompliment: String {
        compliment ?? ""
    }
    
    public var unwrappedCreateDate: Date {
        createDate ?? Date()
    }
    
    public var unwrappedID: UUID {
        id ?? UUID()
    }

}

extension ComplimentEntity : Identifiable {

}

extension ComplimentEntity {
    static func add(to context: NSManagedObjectContext, complimentText: String, groupID: Int16) -> ComplimentEntity {
        let order = CoreDataManager.shared.fetchLatestOrder() + 1
        let compliment = ComplimentEntity(context: context)
        compliment.compliment = complimentText
        compliment.createDate = Date()
        compliment.order = order
        compliment.id = UUID()
        compliment.groupID = groupID
        
        return compliment
    }
    
    func update(withNewText newText: String) {
        self.compliment = newText
        try? self.managedObjectContext?.save()
    }
}
