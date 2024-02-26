//
//  CoreDataManager+Controller.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import CoreData

extension CoreDataManager: ComplimentDataController {
    
    func saveContext() {
        do{
            try context.save()
        } catch {
            context.rollback()
        }
    }

    func addCompliment(complimentText: String, groupID: Int16) throws {
        let order = try CoreDataManager.shared.fetchLatestOrder() + 1
        let compliment = ComplimentEntity(context: context)
        
        compliment.compliment = complimentText
        compliment.createDate = Date()
        compliment.order = order
        compliment.id = UUID()
        compliment.groupID = groupID
        
        saveContext()
    }
    
    func deleteCompliment(compliment: ComplimentEntity) throws {
        let orderToDelete = compliment.order
        context.delete(compliment)
        
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order > %d", orderToDelete)
        
        let complimentsToUpdate = try context.fetch(fetchRequest)
        for complimentToUpdate in complimentsToUpdate {
            complimentToUpdate.order -= 1
        }
        
        saveContext()
    }

    func fetchCompliments(request: FetchRequestType) throws -> [ComplimentEntity] {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()

        switch request {
        case .all:
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: false)]
        case .inGroup(let groupID):
            fetchRequest.predicate = NSPredicate(format: "groupID == %d", groupID)
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)]
        case .byOrder(let order):
            fetchRequest.predicate = NSPredicate(format: "order == %d", order)
            fetchRequest.fetchLimit = 1
        }
        
        do {
            let results = try context.fetch(fetchRequest)
            return results
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
