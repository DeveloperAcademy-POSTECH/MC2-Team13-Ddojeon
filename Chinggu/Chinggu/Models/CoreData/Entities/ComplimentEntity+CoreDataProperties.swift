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
}

extension ComplimentEntity : Identifiable {

}

extension ComplimentEntity {
    static func add(context: NSManagedObjectContext, complimentText: String, groupID: Int16) throws {
        let order = try CoreDataManager.shared.fetchLatestOrder() + 1
        let compliment = ComplimentEntity(context: context)
        compliment.compliment = complimentText
        compliment.createDate = Date()
        compliment.order = order
        compliment.id = UUID()
        compliment.groupID = groupID
    }
    
    static func delete(context: NSManagedObjectContext, compliment: ComplimentEntity) throws {
        let orderToDelete = compliment.order
        context.delete(compliment)
        
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order > %d", orderToDelete)
        
        let complimentsToUpdate = try context.fetch(fetchRequest)
        for complimentToUpdate in complimentsToUpdate {
            complimentToUpdate.order -= 1
        }
    }
    
    //나중에 칭찬 수정기능 추가할때
    func update(withNewText newText: String) {
        self.compliment = newText
        try? self.managedObjectContext?.save()
    }
}
