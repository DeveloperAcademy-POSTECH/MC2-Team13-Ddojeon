//
//  Onboarding_4.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_4: View {
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_3(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 0.3, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
                Text("기묘한 긍정의 힘")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                    .padding()
                    .padding(.leading,20)
                    .padding(.top,20)
                    .foregroundColor(Color("oll"))
                
                Text("내면의 긍정 에너지는 몹시 강력해서,\n외부의 좋은 것을 나에게 끌어당기는\n힘이 있어요.")
                    .font(.custom("AppleSDGothicNeo-Semibold", size: 18))
                    .padding()
                    .padding(.leading,20)
                    .lineSpacing(5)
                    .foregroundColor(Color("oll"))
                
                
                //로띠뷰 넣기
                LottiePlayState(filename: "onboarding_4",loopState: false, playState: .constant(true))
                    .offset(x:-20)
                
                
                //버튼 이용해서 navigationlink 만들기
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        NavigationLink(
                            destination: Onboarding_5(),
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

struct Onboarding_4_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding_4()
    }
}


