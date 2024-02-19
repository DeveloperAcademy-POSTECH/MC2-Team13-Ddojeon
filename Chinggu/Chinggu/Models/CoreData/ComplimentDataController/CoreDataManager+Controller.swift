//
//  CoreDataManager+Controller.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import CoreData

extension CoreDataManager: ComplimentDataController {
    
    func addCompliment(complimentText: String, groupID: Int16) throws {
        try ComplimentEntity.add(context: context, complimentText: complimentText, groupID: groupID)
        saveContext()
    }
    
    func deleteCompliment(compliment: ComplimentEntity) throws {
        try ComplimentEntity.delete(context: context, compliment: compliment)
        saveContext()
    }

    func fetchAllCompliments() throws -> [ComplimentEntity] {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: false)]
        
        do {
            let compliments = try context.fetch(fetchRequest)
            return compliments
        } catch {
            throw DataControllerError.fetchError
        }
    }
    
    func fetchComplimentsInGroup(_ groupID: Int16) throws -> [ComplimentEntity] {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "groupID == %d", groupID)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)]
        do {
            return try context.fetch(fetchRequest)
        } catch {
            throw DataControllerError.fetchError
        }
    }
    
    func fetchCompliment(order: Int16) throws -> ComplimentEntity? {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order == %d", order)
        fetchRequest.fetchLimit = 1
        do {
            return try context.fetch(fetchRequest).first
        } catch {
            throw DataControllerError.fetchError
        }
    }
    
    func fetchComplimentsCount() throws -> Int16 {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            return Int16(count)
        } catch {
            throw DataControllerError.fetchError
        }
    }
    
    func fetchLatestOrder() throws -> Int16 {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
        fetchRequest.fetchLimit = 1

        do {
            let lastCompliment = try context.fetch(fetchRequest).first
            return lastCompliment?.order ?? 0
        } catch {
            throw DataControllerError.fetchError
        }
    }
}
