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
        ZStack {
            // 배경색
            LinearGradient(gradient: Gradient(colors: [Color("ddoyellowon"), Color("ddowhiteon")]), startPoint: .topTrailing, endPoint: .bottomLeading)
                .edgesIgnoringSafeArea(.all)
            
            // 프로그래스바
            VStack {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_8(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 0.8, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
                
                // 로띠 이미지
                Spacer()
                ZStack {
                    Image("onboarding_9")
                    Text("짝짝짝!\n첫 번째 칭찬을 적으셨군요")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 18))
                        .opacity(isTextVisible ? 1 : 0)
                        .animation(.linear(duration: 2), value: isTextVisible)
                        .onAppear {
                            isTextVisible = true
                        }
                }
                Spacer()
                
                // 다음 버튼
                NavigationLink(
                    destination: Onboarding_10(),
                    label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(height: 56)
                                .foregroundColor(Color("oll"))
                            Text("다음")
                                .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                .foregroundColor(Color.white)
                        }
                        .padding(.horizontal, 20)
                    })
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
