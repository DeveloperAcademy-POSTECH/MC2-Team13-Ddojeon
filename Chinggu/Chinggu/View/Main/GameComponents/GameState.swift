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
	@Published var selectedWeekday: String = Weekday.today.rawValue
	@Published var isSelectedSameDay: Bool = true
	@Published var shake: CGFloat = 0.0
	
	func updateCanBreakBoxes() {
		let today = Calendar.current.component(.weekday, from: Date())
		let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
		
		if (todayWeekday == selectedWeekday) && !isSelectedSameDay {
			canBreakBoxes = true
			if scene.complimentCount > 0 {
				shake = 4
			}
		} else {
			canBreakBoxes = false
			shake = 0
		}
	}
	
	func shakeAnimation() -> CGFloat {
		return canBreakBoxes && scene.complimentCount > 0 ? 5 : 0
	}
}
