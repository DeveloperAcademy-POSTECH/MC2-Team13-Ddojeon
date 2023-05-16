//
//  Onboarding_7.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_7: View {
    @State private var playState = false
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_6(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 0.6, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
                
                    Text("칭찬이 다소\n낯설게 다가온다면 - ")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                        .padding()
                        .padding(.leading,20)
                        .padding(.top,20)
                        .lineSpacing(5)
                        .foregroundColor(Color("oll"))
                
                Text("작성화면 상단에 있는 〈칭찬요정〉이\n당신을 언제든 도와줄 거예요")
                    .font(.custom("AppleSDGothicNeo-Semibold", size: 18))
                    .padding()
                    .padding(.leading,20)
                    .lineSpacing(7)
                    .foregroundColor(Color("oll"))
                    
//                    로띠뷰 넣기
                LottiePlayState(filename: "onboarding_8",loopState: false, playState: .constant(true))
                HStack{
                    Spacer()
                    Text("본 가이드는 저서 ‘일단 나부터 칭찬합시다’를 기반으로 작성되었어요")
                        .font(.custom("AppleSDGothicNeo", size: 12))
                        .foregroundColor(Color.gray)
                        .padding(.bottom,20)

                    Spacer()
                }
    
                //버튼 이용해서 navigationlink 만들기
                
                HStack{
                    Spacer()
                    Button(action: {
                        
                    }) {
                        NavigationLink(
                            destination: Onboarding_8(),
                            label: {
                                Text("다음")
                                    .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .kerning(1)
                                    .padding(.vertical,6)
                                    .frame(width: geometry.size.width/1.15, height: 50)
                            })
                        
                    }
                    .frame(width: geometry.size.width/1.15, height: 50)
                    .buttonStyle(BorderedButtonStyle())
                    .background(Color.black)
                    .cornerRadius(10)
                    Spacer()
                }
                }
        }
        .navigationBarBackButtonHidden()
    }
}
    struct Onboarding_7_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_7()
        }
    }
