//
//  ComplimentTips.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import Foundation

struct Category {
    var id = UUID()
    var title: String
    var example: String

    init(title: String, example: String) {
        self.title = title
        self.example = example
    }
}

enum Categories: CaseIterable {
    case innerSelf
    case appearance
    case positiveAttiude
    case freshIdea
    case emotion
    case theProcessOfEffort
    case pastSelf
    case resistingTemptation
    case action
    case innerRealization

    var title: String {
        switch self {
        case .innerSelf: return "내면"
        case .appearance: return "외모"
        case .positiveAttiude: return "긍정적인 태도"
        case .freshIdea: return "색다른 발상"
        case .emotion: return "감성"
        case .theProcessOfEffort: return "노력한 과정"
        case .pastSelf: return "과거의 자신"
        case .resistingTemptation: return "유혹을 참은 것"
        case .action: return "행동"
        case .innerRealization: return "내적 깨달음"
        }
    }

    var example: String {
        switch self {
        case .innerSelf: return "평소 대화할 때 일부러 긍정적인 단어를\n의식해서 쓰고 있는 요즘. (오히려 좋아)\n마음이 가볍고 왠지 웃음이 난다."
        case .appearance: return "오늘 1인 미용실에 가서 처음으로\n시도해본 머리가 마음에 쏙 든다.\n다음엔 좀 더 과감한 시도를?"
        case .positiveAttiude: return "과제 기한이 너무 촉박했지만,\n‘일단-의외로-별거아냐’ 마법의 키워드로\n완료..! 고생했다 나 자신🥹"
        case .freshIdea: return "올해는 갓생스러운 삶을 살기로 했지만\n미라클 모닝은 쉽지 않다. 그래서 나는\n미라클 나잇(?) 으로 살기로 했다."
        case .emotion: return "윤슬이 비추는 한강을 바라보며\n불안한 마음을 차분히 다스릴 수 있었다.\n힘들 때 종종 밖으로 나와보자."
        case .theProcessOfEffort: return "요즘 도전하고 있는 책을 기한 내에\n읽진 못했지만, 가능한 선까지 읽었다.\n상황에 맞는 꾸준한 노력이 최고🫡"
        case .pastSelf: return "오늘 친구가 물어본 질문은 예전의\n내가 이미 고민했던 내용이라 적절한\n조언을 줄 수 있었다. 다행이다."
        case .resistingTemptation: return "택시를 타고 싶었지만, 꾹 참고\n대중교통을 이용한 나 칭찬해 ~\n내일도 할 수 있다🫶"
        case .action: return "신호등에서 비를 맞고 있는 누군가에게\n잠시 우산을 씌워주었다. 작은 선의지만\n되려 내가 더 기분 좋았다."
        case .innerRealization: return "오늘은 좋은 결과를 얻은 날이다.\n과거의 내가 했던 선택이 현재를 만드는\n결과가 되어준 것 같다. 재밌게, 열심히\n살아야지. 화이팅!"
        }
    }
}
