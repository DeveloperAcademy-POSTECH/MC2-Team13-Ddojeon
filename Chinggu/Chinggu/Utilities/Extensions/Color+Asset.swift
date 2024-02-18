//
//  Color+Chinggu.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI
 
extension Color {
	//App Color
	static let ddoPrimary = Color("ddoPrimary")
	static let ddoOrange = Color("ddoOrange")
	static let ddoYellow = Color("ddoYellow")
    static let ddoSheet1 = Color("ddoTip1")
    static let ddoSheet2 = Color("ddoTip2")
    static let ddoSheet3 = Color("ddoTip3")
    static let ddoSheet4 = Color("ddoTip4")
    static let ddoSheet5 = Color("ddoTip5")
    static let ddoSheet6 = Color("ddoTip6")
    static let ddoSheet7 = Color("ddoTip7")
    static let ddoSheet8 = Color("ddoTip8")
    static let ddoSheet9 = Color("ddoTip9")
    static let ddoSheet10 = Color("ddoTip10")
    static let lightgray = Color(red: 0.85, green: 0.85, blue: 0.85)
}
 
extension Color {
   init(hex: UInt, alpha: Double = 1) {
	   self.init(
		   .sRGB,
		   red: Double((hex >> 16) & 0xff) / 255,
		   green: Double((hex >> 08) & 0xff) / 255,
		   blue: Double((hex >> 00) & 0xff) / 255,
		   opacity: alpha
	   )
   }
}
