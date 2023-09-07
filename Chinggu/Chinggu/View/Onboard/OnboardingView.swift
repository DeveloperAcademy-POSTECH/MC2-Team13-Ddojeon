//
//  OnboardingView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/15.
//

import SwiftUI

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
                tabView
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

    private var progressBar: some View {
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

    private var tabView: some View {
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
            case 1: animationTitle
            default: titleAndDescription
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 20)
    }

    private var animationTitle: some View {
        VStack {
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
    }

    private var titleAndDescription: some View {
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

struct GoNextButton: View {
    @Binding var selection: Int
    @State var length: Int
    @State var onboardings: [Onboarding]
    @Binding var showMain: Bool

    var body: some View {
        Button(action: {
            if selection == length {
                showMain = true
                UserDefaults.standard.set(true, forKey: "HasOnboarded")
            } else {
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
