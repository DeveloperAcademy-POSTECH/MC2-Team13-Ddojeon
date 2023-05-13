//
//  Onboarding_6.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_6: View {
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack {
                //뒤로가기, gaugebar HStack으로 묶기
                HStack{
                    Button(action: {
                        
                    }) {
                        //navigationlink 이용해서 뒤로가기
                        NavigationLink(
                            destination: Onboarding_5(),
                            label: {
                                Image(systemName: "chevron.backward")
                                    .foregroundColor(Color.black)
                                    .scaleEffect(1.7)
                            })
                        
                    }
                    //왼쪽 공간 띄워놓기
                    .padding(.leading,30)
                    
                    //gaugebar
                    ProgressView(value: 0.5, total: 1.0)
                        .padding(.trailing,25)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color(red: 28/255, green: 28/255, blue: 30/255))
                        )
                }
                
                Text("칭찬을\n한 번 적어볼까요?")
                    .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                    .multilineTextAlignment(.center)
                    
                    .padding(.leading,20)
                    .padding(.top,50)
                    .lineSpacing(5)
                    .foregroundColor(Color("oll"))
                    .padding()
                
                //로띠뷰 넣기
                LottieView(filename: "onboarding_6",loopState: false,playState: .constant(true))
                    .scaleEffect(1.15)
                    .padding(.bottom,20)
                
                //버튼 이용해서 navigationlink 만들기
                HStack{
                    Spacer()
                    Button(action: {
                        
                    }) {
                        NavigationLink(
                            destination: Onboarding_7(),
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
    struct Onboarding_6_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_6()
        }
    }

