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
    static let ddoSheet1 = Color("ddoTip1_2")
    static let ddoSheet2 = Color("ddoTip2_2")
    static let ddoSheet3 = Color("ddoTip3_2")
    static let ddoSheet4 = Color("ddoTip4_2")
    static let ddoSheet5 = Color("ddoTip5_2")
    static let ddoSheet6 = Color("ddoTip6_2")
    static let ddoSheet7 = Color("ddoTip7_2")
    static let ddoSheet8 = Color("ddoTip8_2")
    static let ddoSheet9 = Color("ddoTip9_2")
    static let ddoSheet10 = Color("ddoTip10_2")
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
