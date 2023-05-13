//
//  Onboarding_9.swift
//  Chinggu
//
//  Created by OLING on 2023/05/12.
//


import SwiftUI
import UIKit

struct Onboarding_9: View {
    @State var isTextVisible = false
    
    var body: some View {
        GeometryReader{ geometry in
            //배경색 바꾸기
            LinearGradient(gradient: Gradient(colors: [Color("ddoyellowon"), Color("ddowhiteon")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            ZStack{
                
                Image("onboarding9")
                    .scaleEffect(1.1)
                
                VStack(alignment:.leading) {
                    //뒤로가기, gaugebar HStack으로 묶기
                    HStack{
                        Button(action: {
                            
                        }) {
                            //navigationlink 이용해서 뒤로가기
                            NavigationLink(
                                destination: Onboarding_8(),
                                label: {
                                    Image(systemName: "chevron.backward")
                                        .scaleEffect(1.7)
                                        .foregroundColor(Color.black)
                                })
                            
                        }
                        //왼쪽 공간 띄워놓기
                        .padding(.leading,30)
                        
                        //gaugebar
                        ProgressView(value: 0.8, total: 1.0)
                            .padding(.trailing,25)
                            .scaleEffect(y:1.3)
                            .progressViewStyle(
                                LinearProgressViewStyle(tint: Color(red: 28/255, green: 28/255, blue: 30/255))
                            )
                    }
                    
                    Text("짝짝짝!\n첫 번째 칭찬을 적으셨군요.")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 18))
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.18, alignment: .center)
                        .multilineTextAlignment(.center)
                        .lineSpacing(5)
                        .foregroundColor(Color("oll"))
                        .opacity(self.isTextVisible ? 1.0 : 0.0)
                    
                    
                    //버튼 이용해서 navigationlink 만들기
                    HStack{
                        Spacer()
                        Button(action: {
                            
                        }) {
                            NavigationLink(
                                destination: Onboarding_10(),
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
            .onAppear{
                withAnimation(Animation.linear(duration: 3)) {
                    self.isTextVisible = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}
    struct Onboarding_9_Previews: PreviewProvider {
        static var previews: some View {
            Onboarding_9()
        }
    }

