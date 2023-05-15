//
//  OnboardingView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/15.
//

import SwiftUI

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
    case onboarding_6
    case onboarding_7
    case onboarding_8
    case onboarding_9
    case onboarding_10
    case onboarding_11
    
    var title: String {
        switch self {
        case .onboarding_2: return "부정적인 감정에서\n흔들리지 않는 마음을\n만들어 드릴게요"
        case .onboarding_3: return "남과 비교하지 않는\n단단한 자아는\n칭찬으로부터 시작돼요"
        case .onboarding_4: return "기묘한 긍정의 힘"
        case .onboarding_6: return "그럼 이제 칭찬을\n한번 적어볼까요?"
        case .onboarding_7: return "효과적인 칭찬 방법을\n알려드릴게요"
        case .onboarding_9: return "아직 칭찬이\n어려워도 괜찮아요"
        case .onboarding_10: return "매주 한 번\n칭찬 언-박싱 타임!"
        case .onboarding_11: return "이제 칭구와 함께\n시작해요"
        default: return ""
        }
    }
    
    var description: String {
        switch self {
        case .onboarding_4: return "내면의 긍정 에너지는 몹시 강력해서\n외부의 좋은 것을 나에게 끌어당기는\n힘이 있어요"
        case .onboarding_7: return "친구나 아이를 대하듯 나를 칭찬해보세요!\n행동 + 칭찬의 말을 함께 덧붙이면 좋아요"
        case .onboarding_9: return "작성화면 상단에 있는 〈칭찬요정〉이\n당신을 언제든 도와줄 거예요"
        case .onboarding_10: return "이전에 열람한 칭찬은 보관함에서\n모두 쉽게 관리할 수 있어요"
        case .onboarding_11: return "매일 하루 끝 칭찬으로 긍정적인\n사고 회로를 만들어 보아요"
        default: return ""
        }
    }
    
    var nextButton: String {
        switch self {
        case .onboarding_1: return "시작하기"
            //        case .onboarding_5: return ""
        case .onboarding_10: return "요일설정"
        case .onboarding_11: return "칭구 시작하기"
        default: return "다음"
        }
    }
}

struct OnboardingView: View {
    let onboardings: [Onboarding] = Onboardings.allCases.map {
        Onboarding(title: $0.title,
                   description: $0.description,
                   nextButton: $0.nextButton)
    }
    @State private var selection = 1
    @State private var currentIndex = 1
    
    var body: some View {
        VStack {
            ProgressBar(selection: $selection,
                        currentIndex: $currentIndex,
                        length: onboardings.count)
            
            TabView(selection: $selection) {
                ForEach(1...onboardings.count, id: \.self) { idx in
                    VStack {
                        OnboardingTextView(onboardings: onboardings, index: idx)
                        switch idx {
                        case 5: CutChainView(
                            selection: $selection,
                            currentIndex: $currentIndex,
                            length: onboardings.count,
                            onboardings: onboardings)
                        default: LottiePlayState(filename: "onboarding_\(idx)",
                                                 loopState: true,
                                                 playState: .constant(true))
                        .scaleEffect(idx == 1 ? 0.55 : 1)
                        }
                    }
                    .tag(idx)
                    .onAppear {
                        currentIndex = idx
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            
            if selection != 5 {
                GoNextButton(
                    selection: $selection,
                    currentIndex: $currentIndex,
                    length: onboardings.count,
                    onboardings: onboardings
                )
            }
        }
        .background(currentIndex == 5 ? Color("ddopurplebackground") :Color.ddoPrimary)
    }
}

struct ProgressBar: View {
    @Binding var selection: Int
    @Binding var currentIndex: Int
    @State var length: Int
    
    var body: some View {
        HStack(spacing: 8) {
            if selection != 1 {
                Button(action: {
                    selection = selection > 2 ? selection - 1 : 1
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .frame(width: 44, alignment: .leading)
                })
                ProgressView(value: Double(currentIndex-1) / Double(length-1), total: 1.0)
                    .scaleEffect(y:1.3)
                    .progressViewStyle(
                        LinearProgressViewStyle(tint: Color("oll"))
                    )
            }
        }
        .frame(height: 44)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    }
}

struct OnboardingTextView: View {
    @State var onboardings: [Onboarding]
    @State var index: Int
    
    @State private var messageIndex = 0
    private let message = ["불안", "무기력", "슬픔", "우울", "조급함", "자괴감", "회의감", "좌절"]
    private let timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            switch index {
            case 1:  VStack {
                HStack(spacing: 5) {
                    Text("최근")
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: 72, height: 36)
                            .foregroundColor(Color("oll"))
                        Text(message[messageIndex])
                            .bold()
                            .font(.body)
                            .foregroundColor(Color.ddoPrimary)
                    }
                    Text("을")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                Text("느껴본 적 없나요?")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .bold()
            .font(.title)
            .lineSpacing(6)
            .onReceive(timer) { _ in
                messageIndex = (messageIndex + 1) % message.count
            }
            case 5, 8: VStack {}
            default:    VStack {
                Text(onboardings[index - 1].title)
                    .bold()
                    .font(.title)
                    .lineSpacing(6)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 8)
                if !onboardings[index - 1].description.isEmpty {
                    Text(onboardings[index - 1].description)
                        .lineSpacing(3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .kerning(-0.1)
                }
            }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct GoNextButton: View {
    @Binding var selection: Int
    @Binding var currentIndex: Int
    @State var length: Int
    @State var onboardings: [Onboarding]
    
    var body: some View {
        Button(action: {
            selection = selection < length ? selection + 1 : length
        }, label: {
            //            if selection != 5 {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 56)
                    .foregroundColor(selection == length ? Color.blue : Color("oll"))
                Text(onboardings[currentIndex - 1].nextButton)
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal, 20)
            //            }
        })
    }
}

struct CutChainView:View {
    @Binding var selection: Int
    @Binding var currentIndex: Int
    @State var length: Int
    @State var onboardings: [Onboarding]
    @State private var isPlaying = false
    
    var body: some View {
        ZStack {
            Image("onboarding5_background")
                .scaleEffect(1.3)
            
            VStack {
                Text("이제 자신을 칭찬하면서\n부정적 감정의 고리를\n끊어 보아요")
                    .fontWeight(.medium)
                    .kerning(-0.1)
                    .lineSpacing(4)
                    .multilineTextAlignment(.center)
                LottiePlayState(filename: "onboarding_5",
                                loopState: false,
                                playState: $isPlaying)
                if isPlaying {
                    GoNextButton(
                        selection: $selection,
                        currentIndex: $currentIndex,
                        length: onboardings.count,
                        onboardings: onboardings
                    )
                } else {
                    Text("고리를 터치해서 끊어보세요!")
                        .bold()
                        .foregroundColor(Color.white)
                        .kerning(-0.08)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        .background(Color("ddopurplebutton"))
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, isPlaying ? 0 : 30)
            
            Button(action: {
                isPlaying = true
            }) {
                Circle()
                    .fill(Color.clear)
                    .scaleEffect(0.7)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
