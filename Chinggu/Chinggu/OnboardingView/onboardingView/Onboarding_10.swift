//
//  Onboarding_10.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

enum Weekday: String, CaseIterable {
    case monday = "월요일"
    case tuesday = "화요일"
    case wednesday = "수요일"
    case thursday = "목요일"
    case friday = "금요일"
    case saturday = "토요일"
    case sunday = "일요일"
}

struct Onboarding_10: View {
    @State private var weekdayActionSheet = false
    @State private var seletedWeekday: Weekday?
    //    @State private var showLottie = false
    @State private var playState = false
    
    
    
    @ViewBuilder
    var lottieView: LottieView {
        LottieView(filename: "onboarding_10",loopState: false, playState: $playState)
    }
    
    var body: some View {
        
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                //뒤로가기, gaugebar HStack으로 묶기
                HStack{
                    Button(action: {
                        
                    }) {
                        //navigationlink 이용해서 뒤로가기
                        NavigationLink(
                            destination: Onboarding_9(),
                            label: {
                                Image(systemName: "chevron.backward")
                                    .scaleEffect(1.7)
                                    .foregroundColor(Color.black)
                            })
                        
                    }
                    //왼쪽 공간 띄워놓기
                    .padding(.leading,30)
                    
                    //gaugebar
                    ProgressView(value: 0.9, total: 1.0)
                        .padding(.trailing,25)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color(red: 28/255, green: 28/255, blue: 30/255))
                        )
                }
                //                    Text(
                //                        UIScreen.main.bounds.width
                //                    )
                Text("매주 한 번,\n칭찬 언-박싱 타임!")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                    .padding()
                    .padding(.leading,20)
                    .padding(.top,20)
                    .foregroundColor(Color("oll"))
                
                Text("이전에 열람한 칭찬은 보관함에서\n모두 쉽게 관리할 수 있어요.")
                    .font(.custom("AppleSDGothicNeo-Semibold", size: 18))
                    .lineSpacing(5)
                    .padding()
                    .padding(.leading,20)
                    .foregroundColor(Color("oll"))
                
                
                //로띠뷰 넣기
                LottieView(filename: "onboarding_10",loopState: false, playState: $playState)
                
                ZStack {
                    //버튼 이용해서 navigationlink 만들기
                    HStack{
                        Spacer()
                        Button(action: {
                            weekdayActionSheet = true
                            print(lottieView.playState)
                        }) {
                            Text("요일 설정")
                                .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                .foregroundColor(Color.white)
                                .kerning(1)
                                .padding(.vertical,6)
                                .frame(width: geometry.size.width/1.15, height: 50)
                        }
                        .frame(width: geometry.size.width/1.15, height: 50)
                        .buttonStyle(BorderedButtonStyle())
                        .background(Color.black)
                        .cornerRadius(10)
                        .actionSheet(isPresented: $weekdayActionSheet) {
                            ActionSheet(title: Text("요일 설정"), message: nil, buttons: Weekday.allCases.map { weekday in
                                
                                return .default(Text(weekday.rawValue)) {
                                    self.weekdayActionSheet = false
                                    self.seletedWeekday = weekday
                                    self.playState = true
                                    self.lottieView.playState = self.playState
                                }
                            }.compactMap { $0 } + [.cancel()])
                        }
                        Spacer()
                    }
                    
                    
                    if self.playState {
                        HStack{
                            Spacer()
                            Button (action: {
                                
                            }) {
                                
                                NavigationLink(
                                    destination: Onboarding_11(),
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
                            Spacer()
                        }

                    }
                }
            }
            
        }
        .navigationBarBackButtonHidden()
    }
    
}
struct Onboarding_10_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding_10()
    }
}
