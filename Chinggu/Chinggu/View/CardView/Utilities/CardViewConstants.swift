//
//  CardViewConstants.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import Foundation

extension CardViewModel {
    enum LottieDuration {
        static let cardBeforeAnimationDuration: Double = 5
    }
    
    enum Animation {
        static let response = 0.6
        static let dampingFraction = 0.8
    }
}

extension CardPopupView {
    enum CardFrame {
        static let width: CGFloat = 350
        static let height: CGFloat = 412
        static let cornerRadius: CGFloat = 15
    }
}
