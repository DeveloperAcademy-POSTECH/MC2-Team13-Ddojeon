//
//  ComplimentViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/25.
//

import Foundation

class ComplimentViewModel: ObservableObject {

	@Published var compliments: [ComplimentEntity] = []
	
	private let persistenceController: PersistenceController
		
	init(persistenceController: PersistenceController) {
		self.persistenceController = persistenceController
		fetchCompliments()
	}
		
	func fetchCompliments() {
		compliments = persistenceController.fetchCompliment()
	}
	
	func addCompliment(complimentText: String, groupID: Int16) {
		persistenceController.addCompliment(complimentText: complimentText, groupID: groupID)
		fetchCompliments()
	}
	
	func deleteCompliment(compliment: ComplimentEntity) {
		persistenceController.deleteCompliment(compliment: compliment)
		fetchCompliments()
	}
	
	func fetchComplimentsInGroup(groupID: Int16) {
		compliments = persistenceController.fetchComplimentInGroup(groupID: groupID)
	}
	
	func deleteAllCompliments() {
		persistenceController.deleteAllCompliments()
		fetchCompliments()
	}
	
	func loadCompliment(order: Int16) -> ComplimentEntity? {
		return persistenceController.loadCompliment(order: order)
	}
}
