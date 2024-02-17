//
//  OnboardingView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/15.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                progressBar
                tabView
                GoNextButton(viewModel: viewModel)
            }
            .background(Color.ddoPrimary)
        }
        .fullScreenCover(isPresented: $viewModel.shouldShowMain) {
            MainView()
        }
    }

    private var progressBar: some View {
        HStack(spacing: 8) {
            if viewModel.selection > 0 {
                Button(action: {
                    viewModel.goBack()
                }, label: {
                    Image(systemName: "chevron.backward")
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .frame(width: 44, alignment: .leading)
                })
                ProgressView(value: Double(viewModel.selection) / Double(viewModel.totalCount), total: 1.0)
                    .scaleEffect(y:1.3)
                    .progressViewStyle(
                        LinearProgressViewStyle(tint: Color("oll"))
                    )
                Button("건너뛰기") {
                    viewModel.goMain()
                }
                .padding(.leading, 10)
                .accentColor(.black)
            }
        }
        .frame(height: 44)
        .padding(.horizontal, 20)
    }

    private var tabView: some View {
        TabView(selection: $viewModel.selection) {
            ForEach(0...viewModel.totalCount, id: \.self) { idx in
                VStack {
                    OnboardingTextView(viewModel: viewModel,
                                       index: idx)
                    LottieView(filename: "onboarding_\(idx)",
                               loopState: true)
                    .scaleEffect(idx == 0 ? 0.55 : 1)
                    .offset(x:0, y: viewModel.selection == 3 ? -40 : 0)
                }
                .tag(idx)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
    }
}


struct OnboardingTextView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    var index: Int
    @State private var messageIndex = 0
    private let timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            switch index {
            case 0: animationTitle
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
                    Text(viewModel.animationMessages[messageIndex])
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
            messageIndex = (messageIndex + 1) % viewModel.animationMessages.count
        }
    }

    private var titleAndDescription: some View {
        VStack {
            Text(viewModel.onboardings[index].title)
                .bold()
                .font(.title)
                .lineSpacing(6)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 8)
            if !viewModel.onboardings[index].description.isEmpty {
                Text(viewModel.onboardings[index].description)
                    .lineSpacing(3)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .kerning(-0.1)
            }
        }
    }
}

struct GoNextButton: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        Button(action: {
            if viewModel.selection == viewModel.totalCount {
                viewModel.goMain()
            } else {
                viewModel.goNext()
            }
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 56)
                    .foregroundColor(viewModel.selection == viewModel.totalCount ? Color.blue : Color("oll"))
                Text(viewModel.onboardings[viewModel.selection].nextButton)
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
