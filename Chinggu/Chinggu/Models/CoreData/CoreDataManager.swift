//
//  CoreDataManager.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import SwiftUI
import CoreData

class CoreDataManager {
    @AppStorage("group") var groupOrder: Int = 1
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
}
