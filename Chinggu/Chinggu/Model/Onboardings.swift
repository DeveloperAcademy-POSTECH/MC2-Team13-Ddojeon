//
//  Onboardings.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import Foundation

struct Onboarding {
    var id = UUID()
    var title: String
    var description: String
    var nextButton: String

    init(title: String, description: String, nextButton: String) {
        self.title = title
        self.description = description
        self.nextButton = nextButton
    }
}

enum Onboardings: CaseIterable {
    case onboarding_1
    case onboarding_2
    case onboarding_3
    case onboarding_4
    case onboarding_5

    var title: String {
        switch self {
        case .onboarding_1: return "최근 무기력을\n느껴본 적 없나요?"
        case .onboarding_2: return "부정적인 감정에서\n흔들리지 않는 마음을\n만들어 드릴게요"
        case .onboarding_3: return "기묘한 긍정의 힘"
        case .onboarding_4: return "아직 칭찬이\n어려워도 괜찮아요"
        case .onboarding_5: return "이제 칭구와 함께\n시작해요"
        }
    }

    var description: String {
        switch self {
        case .onboarding_3: return "내면의 긍정 에너지는 몹시 강력해서\n외부의 좋은 것을 나에게 끌어당기는\n힘이 있어요"
        case .onboarding_4: return "하단의 작성 tip을 클릭하면,\n당신을 언제든 도와줄거에요."
        case .onboarding_5: return "매일 하루 끝 칭찬으로 긍정적인\n사고 회로를 만들어 보아요"
        default: return ""
        }
    }

    var nextButton: String {
        switch self {
        case .onboarding_1: return "시작하기"
        case .onboarding_5: return "칭구 시작하기"
        default: return "다음"
        }
    }
}
