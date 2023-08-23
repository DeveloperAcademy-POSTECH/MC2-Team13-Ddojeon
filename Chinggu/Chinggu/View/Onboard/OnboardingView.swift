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

struct OnboardingView: View {
    let onboardings: [Onboarding] = Onboardings.allCases.map {
        Onboarding(title: $0.title,
                   description: $0.description,
                   nextButton: $0.nextButton)
    }
    @State private var selection = 1
    @State private var showMain = false

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                progressBar
                TabView(selection: $selection) {
                    ForEach(1...onboardings.count, id: \.self) { idx in
                        VStack {
                            OnboardingTextView(onboardings: onboardings, index: idx)
                            LottieView(filename: "onboarding_\(idx)",
                                       loopState: true)
                            .scaleEffect(idx == 1 ? 0.55 : 1)
                            .offset(x:0, y: selection == 4 ? -40 : 0)
                        }
                        .tag(idx)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))

                GoNextButton(
                    selection: $selection,
                    length: onboardings.count,
                    onboardings: onboardings,
                    showMain: $showMain
                )
            }
            .background(Color.ddoPrimary)
        }
        .fullScreenCover(isPresented: $showMain) {
            MainView()
        }
    }

    var progressBar: some View {
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

                ProgressView(value: Double(selection - 1) / Double(onboardings.count - 1), total: 1.0)
                    .scaleEffect(y:1.3)
                    .progressViewStyle(
                        LinearProgressViewStyle(tint: Color("oll"))
                    )
                Button("건너뛰기") {
                    showMain = true
                    UserDefaults.standard.set(true, forKey: "HasOnboarded")
                }
                .padding(.leading, 10)
                .accentColor(.black)
            }
        }
        .frame(height: 44)
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
            default:
                VStack {
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
        .padding(.top, 20)
    }
}

struct GoNextButton: View {
    @Binding var selection: Int
    @State var length: Int
    @State var onboardings: [Onboarding]
    @Binding var showMain: Bool

    var body: some View {
        Button(action: {
            if selection == length {
                // 메인화면으로 이동
                showMain = true
                UserDefaults.standard.set(true, forKey: "HasOnboarded")
            } else {
                // 다음 페이지 이동
                selection = selection < length ? selection + 1 : length
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 56)
                    .foregroundColor(selection == length ? Color.blue : Color("oll"))
                Text(onboardings[selection - 1].nextButton)
                    .bold()
                    .font(.title3)
                    .foregroundColor(Color.white)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
