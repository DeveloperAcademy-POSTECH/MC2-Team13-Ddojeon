//
//  Onboarding_3.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_3: View {
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment:.leading) {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_2(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 0.2, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
        
                    Text("남과 비교하지 않는\n단단한 자아는\n칭찬으로부터 시작돼요")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                        .padding()
                        .padding(.leading,20)
                        .padding(.top,20)
                        .foregroundColor(Color("oll"))
                        .lineSpacing(5)
                    
                    //로띠뷰 넣기
                LottiePlayState(filename: "onboarding_3",loopState: false, playState: .constant(true))
                    
                //버튼 이용해서 navigationlink 만들기
                HStack {
                    Spacer()
                    Button(action: {
                            
                        }) {
                            NavigationLink(
                                destination: Onboarding_4(),
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
    struct Onboarding_3_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_3()
        }
    }
