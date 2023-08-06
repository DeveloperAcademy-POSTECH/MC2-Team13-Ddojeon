//
//  Weekday+today.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/06.
//

import Foundation

extension Weekday {
	static var today: Weekday {
		let index = (Calendar.current.component(.weekday, from: Date()) + 5) % 7
		return Weekday.allCases[index]
	}
}
