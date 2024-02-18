//
//  ShakeEffect.swift
//  Chinggu
//
//  Created by Junyoo on 2/18/24.
//

import SwiftUI

struct ShakeEffect: AnimatableModifier {
    var delta: CGFloat = 0
    
    var animatableData: CGFloat {
        get { delta }
        set { delta = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: sin(delta * .pi * 4.0) * CGFloat.random(in: 0.5...1.5)))
            .offset(x: sin(delta * 1.5 * .pi * 1.2),
                    y: cos(delta * 1.5 * .pi * 1.1))
    }
}
