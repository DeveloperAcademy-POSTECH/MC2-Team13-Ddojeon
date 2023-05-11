//
//  Persistence.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/08.
//

import CoreData

struct PersistenceController {
	static let shared = PersistenceController()

	static var preview: PersistenceController = {
		let result = PersistenceController(inMemory: true)
		let viewContext = result.container.viewContext
		for item in 0..<10 {
			let newCompliment = ComplimentEntity(context: viewContext)
			newCompliment.compliment = "Preview \(item)"
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
}
