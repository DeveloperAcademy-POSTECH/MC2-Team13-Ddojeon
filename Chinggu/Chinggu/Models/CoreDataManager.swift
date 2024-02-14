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

    //MARK: CREATE
    func addCompliment(complimentText: String, groupID: Int16) {
        let order = fetchLatestOrder() + 1
        let compliment = ComplimentEntity(context: context)
        compliment.compliment = complimentText
        compliment.createDate = Date()
        compliment.order = order
        compliment.id = UUID()
        compliment.groupID = groupID
        saveContext()
    }

    //MARK: READ
    func fetchCompliment() -> [ComplimentEntity] {
        do {
            let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch all ComplimentEntity: \(error)")
        }
        return []
    }

    func updateCompliment(compliment: ComplimentEntity) {
        let fetchResults = fetchCompliment()
        for result in fetchResults {
            if result.id == compliment.id {
    //                result.compliment = compliment.compliment
            }
        }
        saveContext()
    }

    //MARK: Delete
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

    func loadCompliment(order: Int16) -> ComplimentEntity? {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "order == %d", order)
        fetchRequest.fetchLimit = 1
        do {
            let result = try context.fetch(fetchRequest)
            return result.first
        } catch {
            print("Failed to fetch a order of ComplimentEntity: \(error)")
            return nil
        }
    }

    func fetchComplimentInGroup(groupID: Int16) -> [ComplimentEntity] {
        do {
            let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "groupID == %d", groupID)
            fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)]
            let results = try context.fetch(fetchRequest)
            return results
        } catch {
            print("Failed to fetch group of ComplimentEntity: \(error)")
        }
        return []
    }

    func deleteAllCompliments() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ComplimentEntity.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Delete all data in ComplimentEntity failed: \(error)")
        }
    }

    private func saveContext() {
        do{
            try context.save()
        } catch {
            context.rollback()
        }
    }

    private func fetchLatestOrder() -> Int16 {
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
