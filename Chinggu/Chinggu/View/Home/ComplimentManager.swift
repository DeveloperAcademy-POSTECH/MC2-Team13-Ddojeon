//
//  ComplimentManager.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/09.
//

import Foundation

class ComplimentManager: ObservableObject {
	
	@Published var allCompliments: [ComplimentEntity] = []
	@Published var hasComplimentToday: Bool = false
	
	private var persistenceController = PersistenceController.shared
	
	init() {
		fetchAllCompliments()
	}
	
	func fetchAllCompliments() {
		self.allCompliments = persistenceController.fetchCompliment()
		if let latestCompliment = allCompliments.last, Calendar.current.isDateInToday(latestCompliment.createDate ?? Date()) {
			hasComplimentToday = true
		}
	}
	
	func addCompliment(complimentText: String, groupID: Int16) {
		persistenceController.addCompliment(complimentText: complimentText, groupID: groupID)
		fetchAllCompliments()
	}
	
	func fetchComplimentsInGroup(groupID: Int) -> [ComplimentEntity] {
		return allCompliments.filter { $0.groupID == groupID }
	}
	
}
