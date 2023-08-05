//
//  GameState.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/06.
//

import Foundation

class GameState: ObservableObject {
	@Published var scene: GameScene = GameScene()
	@Published var canBreakBoxes: Bool = false
	@Published var selectedWeekday: String = Weekday.allCases[(Calendar.current.component(.weekday, from: Date()) + 5) % 7].rawValue
	@Published var isSelectedSameDay: Bool = true
	
	func updateCanBreakBoxes() {
		let today = Calendar.current.component(.weekday, from: Date())
		let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
		
		if (todayWeekday == selectedWeekday) && !isSelectedSameDay {
			canBreakBoxes = true
			if scene.complimentCount > 0 {
				//shake변수값 바꾸기?
			}
		} else {
			canBreakBoxes = false
		}
	}
}
