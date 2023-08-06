//
//  MainStore.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/06.
//

import Foundation

class MainStore: ObservableObject {
	@Published var isfirst: Bool = false
	@Published var showInfoPopup: Bool = false
	@Published var complimentsInGroup: [ComplimentEntity] = []

}

