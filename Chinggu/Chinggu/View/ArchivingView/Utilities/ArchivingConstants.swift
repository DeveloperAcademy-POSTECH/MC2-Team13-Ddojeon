//
//  ArchivingConstants.swift
//  Chinggu
//
//  Created by Junyoo on 2023/06/18.
//

import SwiftUI

//MARK: ArchivingCard 상수
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
    
    enum ColorStyle {
        static let colors: [Color] = [
                    Color("ddoTip1"),
                    Color("ddoTip2"),
                    Color("ddoTip3"),
                    Color("ddoTip4"),
                    Color("ddoTip5"),
                    Color("ddoTip6"),
                    Color("ddoTip7"),
                    Color("ddoTip8"),
                    Color("ddoTip9"),
                    Color("ddoTip10")
                ]
        
        static func randomColor() -> Color {
            let randomIndex = Int.random(in: 0..<colors.count)
            return colors[randomIndex]
        }
    }
}

//MARK: ArchivingDetailView 상수
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
	
	enum ButtonStyle {
		static let buttonCornerRadius: CGFloat = 15
	}
    
    enum RectangleStyle {
        static let roundedRectangleRadius: CGFloat = 15
    }
}
