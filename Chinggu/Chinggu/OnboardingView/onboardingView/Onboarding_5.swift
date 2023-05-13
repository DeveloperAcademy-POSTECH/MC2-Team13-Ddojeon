//
//  Onboarding_5.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_5: View {
    
    // 뷰의 상태를 나타내는 속성들
    @State private var showAnimation = false
    @State private var isNavigationActive = false
    @State private var playState = false
   
    @ViewBuilder
    var lottieView: LottieView {
        LottieView(filename: "onboarding_5",loopState: false, playState: $playState)
    }
    
    var body: some View {
        GeometryReader { geometry in
            
            // 배경색 설정
            Color("ddopurplebackground")
                .edgesIgnoringSafeArea(.all)
            
            // ZStack을 이용해 이미지와 뷰들을 겹쳐서 표시
            ZStack {
                
                Image("onboarding5_background")
                    .scaleEffect(1.3)
                
                // VStack으로 묶어 UI 구성
                VStack {
                    // 뒤로 가기 버튼과 게이지 바를 HStack으로 묶어서 표시
                    HStack {
                        Button(action: {
                            
                        }) {
                            // NavigationLink를 이용해 뒤로 가기 화면 구현
                            NavigationLink(destination: Onboarding_4()) {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.black)
                                    .scaleEffect(1.7)
                            }
                        }
                        // 뒤로 가기 버튼과 게이지 바 사이의 간격 설정
                        .padding(.leading, 30)
                        
                        // 게이지 바 구현
                        ProgressView(value: 0.4, total: 1.0)
                            .padding(.trailing, 25)
                            .scaleEffect(y:1.3)
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(red: 28/255, green: 28/255, blue: 30/255)))
                    }
                    
                    // 타이틀과 설명 문구 표시
                    Text("이제 자신을 칭찬하면서\n부정적 감정의 고리를\n 끊어보아요.")
                        .font(.custom("AppleSDGothicNeo-Semibold", size: 21))
                        .lineSpacing(5)
                        .padding(.top, 40)
                        .foregroundColor(Color("oll"))
                        .multilineTextAlignment(.center)
                    
                    
                    LottieView(filename: "onboarding_5",loopState: false, playState: $playState)
                        .padding(.bottom,90)
                    
                    ZStack {
                        
                        Button(action: {
                        }) {
                            Text("고리를 터치해서 끊어보아요!")
                                                            .font(.custom("AppleSDGothicNeo-Bold", size: 16))
                                                            .foregroundColor(Color.white)
                                                            .kerning(1)
                                                            .padding(.horizontal, 10)
                                                            .padding(.vertical, 6)
                        }
                        .buttonStyle(BorderedButtonStyle())
                                                .frame(width: geometry.size.width/1.3, height: 50)
                                                .background(Color("ddopurplebutton"))
                                                .cornerRadius(10)
                                                   
                        
                        if self.playState {
                            Button (action: {
                                
                            }) {
                                
                                NavigationLink(
                                    destination: Onboarding_6(),
                                    label: {
                                        Text("다음")
                                            .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                            .foregroundColor(Color.white)
                                            .kerning(1)
                                            .padding(.vertical,6)
                                            .frame(width: geometry.size.width/1.15, height: 50)
                                    }
                                )
                            }
                            .frame(width: geometry.size.width/1.15, height: 50)
                            .buttonStyle(BorderedButtonStyle())
                            .background(Color.black)
                            .cornerRadius(10)
                        }
                        
            
                    }
                }
                
                Button(action: {
                    print(lottieView.playState)
                    self.playState = true
                    self.lottieView.playState = self.playState
                }) {
                    Circle()
                        .fill(Color.clear)
                        .scaleEffect(0.7)
                }
                
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct Onboarding_5_Previews: PreviewProvider {
               static var previews: some View {
                   Onboarding_5()
               }
           }
