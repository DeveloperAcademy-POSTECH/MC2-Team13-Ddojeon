//
//  CoreDataManager.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ChingguModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    func saveContext() {
        do{
            try context.save()
        } catch {
            context.rollback()
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

extension CoreDataManager {
    func addCompliment(complimentText: String, groupID: Int16) {
        let newCompliment = ComplimentEntity.add(to: context, complimentText: complimentText, groupID: groupID)
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
            print("Failed to fetch compliments to delete: \(error)")
        }

        saveContext()
    }
    
    func deleteCompliment(_ compliment: ComplimentEntity) {
        let orderToDelete = compliment.order
        context.delete(compliment)
        decrementOrdersStarting(after: orderToDelete)
        saveContext()
    }

    private func decrementOrdersStarting(after order: Int16) {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order > %d", order)
        if let complimentsToUpdate = try? context.fetch(fetchRequest) {
            for complimentToUpdate in complimentsToUpdate {
                complimentToUpdate.order -= 1
            }
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
            print("Error fetching count: \(error)")
            return 0
        }
    }
}
