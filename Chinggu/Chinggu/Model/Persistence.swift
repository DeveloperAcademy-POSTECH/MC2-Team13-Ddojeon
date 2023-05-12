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
	func addCompliment(complimentText: String, groupID: Int16) {
		let order = fetchLatestOrder() + 1
		let compliment = ComplimentEntity(context: container.viewContext)
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
			print(error.localizedDescription)
		}
		return []
	}
	
	//MARK: UPDATE 당장은 쓸일없음!
	func updateCompliment(compliment: ComplimentEntity) {
		let fetchResults = fetchCompliment()
		for result in fetchResults {
			if result.id == compliment.id {
//				result.compliment = compliment.compliment
			}
		}
		saveContext()
	}
	
	//MARK: Delete
	func deleteCompliment(compliment: ComplimentEntity) {
		let orderToDelete = compliment.order
		container.viewContext.delete(compliment)

		let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
		fetchRequest.predicate = NSPredicate(format: "order > %d", orderToDelete)

		do {
			let complimentsToUpdate = try container.viewContext.fetch(fetchRequest)
			// 삭제한 칭찬 이후의 칭찬들(order 값이 높은것들)을 -1씩 해줌
			for complimentToUpdate in complimentsToUpdate {
				complimentToUpdate.order -= 1
			}
		} catch {
			print("Failed to fetch compliments to update: \(error)")
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
			print("Failed to fetch ComplimentEntity: \(error)")
			return nil
		}
	}
	
	private func saveContext() {
		do{
			try container.viewContext.save()
		} catch {
			container.viewContext.rollback()
		}
	}
	
	//마지막 order값 가져오는 함수
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

