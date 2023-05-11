//
//  Persistence.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/08.
//

import CoreData

class PersistenceController {
	
	static let shared = PersistenceController()
	
	let container: NSPersistentContainer
	
	var context: NSManagedObjectContext {
		return container.viewContext
	}
	
	init(inMemory: Bool = false) {
		container = NSPersistentContainer(name: "ComplimentModel")
		if inMemory {
			container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
		}
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
	}
	
	//MARK: READ
	func fetchCompliment() -> [ComplimentEntity] {
		do {
			let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
			let results = try context.fetch(fetchRequest)
			return results
		} catch {
			print(error.localizedDescription)
		}
		return []
	}
	
	private func saveContext() {
		do{
			try container.viewContext.save()
		} catch {
			container.viewContext.rollback()
		}
	}
}

