//
//  Onboarding_11.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//

import SwiftUI
import UIKit

struct Onboarding_11: View {
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            Color("ddocolor").edgesIgnoringSafeArea(.all)
            
            VStack(alignment:.leading) {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_10(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 1.0, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
                
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
                LottiePlayState(filename: "onboarding_18",loopState: false, playState: .constant(true))
                    
                
                //버튼 이용해서 navigationlink 만들기
                HStack{
                    Spacer()
                    Button(action: {
                            
                        }) {
                            NavigationLink(
                                destination: MainView(),
                                label: {
                                    Text("칭구 시작하기")
                                        .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                        .foregroundColor(Color("ddowhiteon"))
                                        .kerning(1)
                                        .padding(.vertical,6)
                                        .frame(width: geometry.size.width/1.2, height: 50)
                                })
                            
                        }
                        .background(Color("ddoOrange"))
                        .frame(width: geometry.size.width/1.15, height: 50)
                        .buttonStyle(BorderedButtonStyle())
                        .cornerRadius(10)
                    Spacer()
                }
                
                }
        }
        .navigationBarBackButtonHidden()
    }
}
    struct Onboarding_11_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_11()
        }
    }

