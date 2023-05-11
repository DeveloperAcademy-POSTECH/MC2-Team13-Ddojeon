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
	
	//MARK: CREATE
	func addCompliment(complimentText: String) {
		let order = fetchLatestOrder() + 1
		let compliment = ComplimentEntity(context: container.viewContext)
		compliment.compliment = complimentText
		compliment.createDate = Date()
		compliment.order = order
		compliment.id = UUID()
		saveContext()
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
	
	//마지막 order값 가져오기
	private func fetchLatestOrder() -> Int16 {
		let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
		fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
		fetchRequest.fetchLimit = 1

		do {
			let lastCompliment = try container.viewContext.fetch(fetchRequest).first
			return lastCompliment?.order ?? 0
		} catch {
			print("Failed to fetch last order: \(error)")
			return 0
		}
	}
}

