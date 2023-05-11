//
//  Date+Chinggu.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/07.
//

import Foundation

extension Date {
	func formatWithDot() -> String {
		let formatter = DateFormatter()
		formatter.locale = Locale(identifier: "ko_KR")
		formatter.dateFormat = "yyyy. MM. dd"
		return formatter.string(from: self)
	}
}

