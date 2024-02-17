//
//  CardViewModel.swift
//  Chinggu
//
//  Created by Junyoo on 2/17/24.
//

import SwiftUI

final class CardViewModel: ObservableObject {
    @Published var showFullScreen = false
    @Published var showText = false
    
    func toggleFullScreen() {
        withAnimation(.spring(response: Animation.response, dampingFraction: Animation.dampingFraction)) {
            showFullScreen = true
        }
    }
    
    func showTextWithDelay() {
        withAnimation (.easeInOut.delay(LottieDuration.cardBeforeAnimationDuration)) {
            showText = true
        }
    }
}
