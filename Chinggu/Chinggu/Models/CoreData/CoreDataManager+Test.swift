//
//  CoreDataForTest.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import CoreData

extension CoreDataManager {
    func testAddCompliment() {
        let viewContext = container.viewContext
        let latestorder = CoreDataManager.shared.fetchLatestOrder()
        for order in 1...7 {
            let newCompliment = ComplimentEntity(context: viewContext)
            if let date = Calendar.current.date(byAdding: .day, value: order, to: Date()) {
                newCompliment.createDate = date
            }
            newCompliment.compliment = "테스트 칭찬 \(order)"
            newCompliment.groupID = Int16(groupOrder)
            newCompliment.order = latestorder + Int16(order)
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
            print("testResetCoreData error: \(error), \(error.userInfo)")
        }
        
    }
    
    func resetDatabase() {
        let entities = container.managedObjectModel.entities
        entities.compactMap({ $0.name }).forEach(clearEntity)
        
        guard let storeUrl = container.persistentStoreDescriptions.first?.url else { return }
        let persistentStoreCoordinator = container.persistentStoreCoordinator
        
        do {
            try persistentStoreCoordinator.persistentStores.forEach { store in
                try persistentStoreCoordinator.remove(store)
                try FileManager.default.removeItem(at: storeUrl)
            }
            container.loadPersistentStores { (storeDescription, error) in
                if let error = error {
                    print("resetDatabase error: \(error.localizedDescription)")
                }
            }
        } catch {
            print("resetDatabase error: \(error.localizedDescription)")
        }
    }
    
    private func clearEntity(entityName: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Clearing error: \(entityName), \(error.localizedDescription)")
        }
    }
}
