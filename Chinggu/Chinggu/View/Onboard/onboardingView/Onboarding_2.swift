//
//  Onboarding_2.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_2: View {
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_1(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 0.1, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
                
                Text("부정적인 감정에서\n흔들리지 않는 마음을\n만들어 드릴게요")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                    .padding()
                    .padding(.leading,20)
                    .padding(.top,20)
                    .lineSpacing(5)
                    .foregroundColor(Color("oll"))
                
                //로띠뷰 넣기
                LottiePlayState(filename: "onboarding_2",loopState: false,playState: .constant(true))
                
                //버튼 이용해서 navigationlink 만들기
                HStack {
                    Spacer()
                    Button(action: {
                        
                    }) {
                        NavigationLink(
                            destination: Onboarding_3(),
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
struct Onboarding_2_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding_2()
    }
}
