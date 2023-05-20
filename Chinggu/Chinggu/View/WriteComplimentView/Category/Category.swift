//
//  Category.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/20.
//

import SwiftUI

struct Category {
	var id = UUID()
	var title: String
	var tipColor: Color
	var sheetColor: Color
	var example: String
	
	init(title: String, tipColor: Color, sheetColor: Color, example: String) {
		self.title = title
		self.tipColor = tipColor
		self.sheetColor = sheetColor
		self.example = example
	}
}
