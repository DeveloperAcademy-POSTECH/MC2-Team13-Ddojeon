//
//  Onboarding_8.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

    
    struct Onboarding_8: View {
        
        
        @State private var inputText: String = ""

        
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
                                destination: Onboarding_7(),
                                label: {
                                    Image(systemName: "chevron.backward")
                                        .scaleEffect(1.7)
                                        .foregroundColor(Color.black)
                                })
                            
                        }
                        //왼쪽 공간 띄워놓기
                        .padding(.leading,30)
                        
                        //gaugebar
                        ProgressView(value: 0.7, total: 1.0)
                            .padding(.trailing,25)
                            .scaleEffect(y:1.3)
                            .progressViewStyle(
                                LinearProgressViewStyle(tint: Color(red: 28/255, green: 28/255, blue: 30/255))
                            )
                    }
                
                    Text("효과적인 칭찬 방법을\n알려드릴게요.")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                        .padding()
                        .padding(.leading,20)
                        .padding(.top,20)
                        .foregroundColor(Color("oll"))
                    
                    Text("친구나 아이를 대하듯 나를 칭찬해보세요!\n행동 + 칭찬의 말을 함께 덧붙이면 좋아요.")
                        .font(.custom("AppleSDGothicNeo-Semibold", size: 18))
                        .lineSpacing(5)
                        .padding()
                        .padding(.leading,20)
                        .foregroundColor(Color("oll"))
                    
                    LottiePlayState(filename: "onboarding_8",loopState: false, playState: .constant(true))
                        .frame(height: 100)
                        .scaleEffect(0.9)

                     HStack{
                            //tectField
                         TextField("칭찬을 입력해 보세요.", text: $inputText, axis: .vertical)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.leading,25)

                            
                       NavigationLink(
                                destination: Onboarding_9(), label: {
                                    Image(systemName: "checkmark.rectangle.portrait.fill")
                                        .bold()
                                        .scaleEffect(2)
                                        .foregroundColor(Color.black)
                                        .padding(.trailing,20)
                                        .padding(.leading, 10)
                        }
                            )
                    }
                     .padding(.bottom,30)
                    Spacer()
                }
            }
            .navigationBarBackButtonHidden()
        }
    }
  
    struct Onboarding_8_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_8()
        }
    }

