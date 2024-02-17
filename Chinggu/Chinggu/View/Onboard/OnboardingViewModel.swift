//
//  OnboardingViewModel.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/14.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @AppStorage("hasOnboarded") var hasOnboarded: Bool = false
    @Published var onboardings: [Onboarding] = Onboardings.allCases.map {
        Onboarding(title: $0.title, description: $0.description, nextButton: $0.nextButton)
    }
    @Published var animationMessages: [String] = OnboardingAnimationMessages.allCases.map { $0.rawValue }
    @Published var totalCount = 0
    @Published var selection = 0
    @Published var shouldShowMain = false

    init() {
        totalCount = onboardings.count - 1
    }

    func goBack() {
        selection = selection > 1 ? selection - 1 : 0
    }

    func goNext(){
        selection = selection < totalCount ? selection + 1 : totalCount
    }

    func goMain() {
        shouldShowMain = true
        hasOnboarded = true
    }
}
