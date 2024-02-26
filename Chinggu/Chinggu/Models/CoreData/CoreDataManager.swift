//
//  CoreDataManager.swift
//  Chinggu
//
//  Created by Junyoo on 2/14/24.
//

import SwiftUI
import CoreData

final class CoreDataManager {
    @AppStorage(AppStorageKeys.groupOrder) var groupOrder: Int = 1
    static let shared = CoreDataManager()
    let containerName = "ChingguModel"
    let nullDevice = "/dev/null"
    
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: containerName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: nullDevice)
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
