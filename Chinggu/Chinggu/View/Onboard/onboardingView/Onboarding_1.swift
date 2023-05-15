//
//  Onboarding_1.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_1: View {
    
    @State private var messageIndex = 0
    private let message = ["불안","무기력","슬픔","우울","조급함","자괴감","회의감","좌절"]
    private let timer = Timer.publish(every: 0.9, on: .main, in: .common).autoconnect()
    
    
    var lottieView = LottiePlayState(filename: "onboarding",loopState: false, playState: .constant(true))
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                //배경색 바꾸기
                Color("ddocolor").edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    VStack(alignment: .leading){
                        HStack {
                            Text("최근")
                            ZStack {
                                RoundedRectangle(cornerRadius: 18)
                                    .frame(width: 72, height: 36)
                                Text(message[messageIndex])
                                    .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                                    .foregroundColor(Color.ddoPrimary)
                            }
                            Text("을")
                        }
                        Text("느껴본 적 없나요?")
                    }
                    .bold()
                    .foregroundColor(Color("oll"))
                    .padding(.top,50)
                    .padding(.leading,30)
                    .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                    
                    
                    //로띠뷰 넣기
                    LottiePlayState(filename: "onboarding_1",loopState: false,playState: .constant(true))
                        .offset(x:-20)
                        .scaleEffect(0.7)
                    
                    
                    //버튼 이용해서 navigationlink 만들기
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }) {
                            NavigationLink(
                                destination: Onboarding_2(),
                                label: {
                                    Text("시작하기")
                                        .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                        .foregroundColor(Color.white)
                                        .kerning(1)
                                        .padding(.vertical,6)
                                        .frame(width: geometry.size.width/1.15, height: 50)
                                })
                            .navigationBarBackButtonHidden()
                            
                        }
                        .frame(width: geometry.size.width/1.15, height: 50)
                        .buttonStyle(BorderedButtonStyle())
                        .background(Color.black)
                        .cornerRadius(10)
                        Spacer()
                    }
                    
                }
                .onReceive(timer) { _ in
                    messageIndex = (messageIndex + 1) % message.count
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct Onboarding_1_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding_1()
    }
}

