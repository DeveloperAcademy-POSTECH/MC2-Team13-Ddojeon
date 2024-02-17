//
//  Persistence.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/08.
//

import CoreData

class PersistenceController {
	
	static let shared = PersistenceController()
	
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<7 {
            let newItem = ComplimentEntity(context: viewContext)
            newItem.createDate = Date()
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    
	let container: NSPersistentContainer
		
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
}

