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
            
            VStack(alignment: .leading) {
                HStack(spacing: 16) {
                    NavigationLink(
                        destination: Onboarding_7(),
                        label: {
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .foregroundColor(Color.black)
                        })
                    ProgressView(value: 0.7, total: 1.0)
                        .scaleEffect(y:1.3)
                        .progressViewStyle(
                            LinearProgressViewStyle(tint: Color("oll"))
                        )
                }
                .frame(height: 43)
                .padding(.horizontal, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("효과적인 칭찬 방법을\n알려드릴게요.")
                        .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                        .lineSpacing(5)
                    Text("친구나 아이를 대하듯 나를 칭찬해보세요!\n행동 + 칭찬의 말을 함께 덧붙이면 좋아요.")
                        .font(.custom("AppleSDGothicNeo-Semibold", size: 18))
                        .kerning(-1)
                        .fontWeight(.medium)
                        .lineSpacing(3)
                }
                .foregroundColor(Color("oll"))
                .padding(.horizontal, 24)
                .padding(.top, 23)
                
                
                LottiePlayState(filename: "onboarding_8", loopState: true, playState: .constant(true))
                    .frame(height: 75)
                    .scaleEffect(0.94)
                
                HStack(spacing: 10) {
                    ZStack(alignment: .topLeading) {
                        RoundedRectangle(cornerRadius: 12)
                            .strokeBorder(lineWidth: 3)
                            .foregroundColor(Color.primary.opacity (0.20))
                            .background(Color.white)
                            .frame(height: 121)
                        if inputText.isEmpty {
                            Text("위 문장을 따라서 입력해보세요.")
                                .lineSpacing(5)
                                .padding(.top, 25)
                                .padding(.leading, 20)
                                .foregroundColor(Color.primary.opacity (0.30))
                        }
                        TextEditor(text: $inputText)
                            .padding()
                            .lineSpacing(8.8)
                            .disableAutocorrection(true)
                            .frame(height: 121)
                            .scrollContentBackground(.hidden)
                    }
                    .font(.custom("AppleSDGothicNeo", size: 15.2))
                    NavigationLink(
                        destination: Onboarding_9(), label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 82, height: 121)
                                    .foregroundColor(Color("oll"))
                                Image(systemName: "checkmark")
                                    .font(.title)
                                    .bold()
                                    .foregroundColor(Color.ddoPrimary)
                            }
                        }
                    )
                }
                .padding(.horizontal, 20)
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

