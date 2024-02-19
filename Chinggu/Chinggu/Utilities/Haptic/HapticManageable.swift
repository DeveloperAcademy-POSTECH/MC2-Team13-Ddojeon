//
//  HapticManageable.swift
//  Chinggu
//
//  Created by Junyoo on 2/19/24.
//

import SwiftUI

protocol HapticManageable {
    func notification(type: UINotificationFeedbackGenerator.FeedbackType)
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle)
}
