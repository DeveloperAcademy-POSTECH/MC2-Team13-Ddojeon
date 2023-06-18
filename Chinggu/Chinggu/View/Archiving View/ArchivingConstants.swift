//
//  ArchivingConstants.swift
//  Chinggu
//
//  Created by Junyoo on 2023/06/18.
//

import SwiftUI

//MARK: ArchivingCard 상수관리
extension ArchivingCard {
	
	enum Metric {
		static let cardInsidePadding: CGFloat = 30
	}
	
	enum CardStyle {
		static let cardCornerRadius: CGFloat = 30
		static let cardLineSpacing: CGFloat = 5
		static let cardHeadlineOpacity: CGFloat = 0.9
		static let cardDateOpacity: CGFloat = 0.3
	}
}

//MARK: ArchivingDetailView 상수관리
extension ArchivingDetailView {
	
	enum Metric {
		static let top: CGFloat = 0
		static let leading: CGFloat = 5
		static let bottom: CGFloat = 30
		static let trailing: CGFloat = 5

		static var ArchivingCardPaddingInsets: EdgeInsets {
			EdgeInsets(top: top,
					   leading: leading,
					   bottom: bottom,
					   trailing: trailing)
		}
	}
	
	enum ColorStyle {
		static let colors: [Color] = [
					Color("ddoTip1_2"),
					Color("ddoTip2_2"),
					Color("ddoTip3_2"),
					Color("ddoTip4_2"),
					Color("ddoTip5_2"),
					Color("ddoTip6_2"),
					Color("ddoTip7_2"),
					Color("ddoTip8_2"),
					Color("ddoTip9_2"),
					Color("ddoTip10_2")
				]
		
		static func randomColor() -> Color {
			let randomIndex = Int.random(in: 0..<colors.count)
			return colors[randomIndex]
		}
	}
	
	enum ButtonStyle {
		static let buttonCornerRadius: CGFloat = 15
	}
}
