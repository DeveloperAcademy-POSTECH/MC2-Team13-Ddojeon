//
//  CoreDataManager+Controller.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import CoreData

extension CoreDataManager: ComplimentDataController {
    func addCompliment(complimentText: String, groupID: Int16) {
        ComplimentEntity.add(to: context, complimentText: complimentText, groupID: groupID)
        saveContext()
    }
    
    func deleteCompliment(compliment: ComplimentEntity) {
        let orderToDelete = compliment.order
        context.delete(compliment)
        
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order > %d", orderToDelete)
        
        do {
            let complimentsToUpdate = try context.fetch(fetchRequest)
            for complimentToUpdate in complimentsToUpdate {
                complimentToUpdate.order -= 1
            }
        } catch {
            print("deleteCompliment Error: \(error)")
        }
        saveContext()
    }

    func fetchAllCompliments() -> [ComplimentEntity] {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: false)]
        
        do {
            let compliments = try context.fetch(fetchRequest)
            return compliments
        } catch {
            print("fetchAllCompliments Error: \(error)")
            return []
        }
    }
    
    func fetchComplimentsInGroup(_ groupID: Int16) -> [ComplimentEntity] {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "groupID == %d", groupID)
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)]
        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    func fetchCompliment(order: Int16) -> ComplimentEntity? {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order == %d", order)
        fetchRequest.fetchLimit = 1
        return try? context.fetch(fetchRequest).first
    }
    
    func fetchComplimentsCount() -> Int16 {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        do {
            let count = try context.count(for: fetchRequest)
            return Int16(count)
        } catch {
            print("fetchComplimentsCount Error: \(error)")
            return 0
        }
    }
    
    func fetchLatestOrder() -> Int16 {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
        fetchRequest.fetchLimit = 1

        do {
            let lastCompliment = try context.fetch(fetchRequest).first
            return lastCompliment?.order ?? 0
        } catch {
            print("Failed to fetch last order: \(error)")
            return 0
        }
    }
}
