//
//  CoreDataManager.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import Foundation
import SwiftUI
import CoreData

class CoreDataManager {
    @AppStorage("group") var groupOrder: Int = 1 {
        didSet {
            print("grouporder = ", groupOrder)
        }
    }
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
    
    func fetchAllCompliments() -> [ComplimentEntity] {
        let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: false)]
        
        do {
            let compliments = try context.fetch(fetchRequest)
            return compliments
        } catch {
            print("Fail to fetch all compliments \(error)")
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
            print("Error fetching count: \(error)")
            return 0
        }
    }
}

extension CoreDataManager {
    func testAddCompliment() {
        let viewContext = container.viewContext
        
        for order in 1...7 {
            let newCompliment = ComplimentEntity(context: viewContext)
            let minusday = -1 * (order - 1)
            if let date = Calendar.current.date(byAdding: .day, value: minusday, to: Date()) {
                newCompliment.createDate = date
            }
            newCompliment.compliment = "테스트 칭찬 \(8 - order)"
            newCompliment.groupID = Int16(groupOrder)
            newCompliment.order = Int16(8 - order)
            newCompliment.id = UUID()
        }
        groupOrder += 1
        saveContext()
    }
        
    func testResetCoreData() {
        let viewContext = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = ComplimentEntity.fetchRequest()
        
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(batchDeleteRequest)
            groupOrder = 1
            saveContext()
        } catch let error as NSError {
            print("Core Data 초기화 실패: \(error), \(error.userInfo)")
        }
    }
}
