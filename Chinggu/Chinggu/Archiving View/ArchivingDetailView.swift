//
//  ArchivingDetailView.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingDetailView: View {
    
    @State var cardText: String = "칭찬 글"
    @State var cardData: String = "6"
    @State var cardOrder: String = "45"
    @State var cardDate: String = "2023. 05. 09"
    
    @State private var cardColor = Color.ddoOrange
    
    let colors = [
        Color.ddoRed,
        Color.ddoBlue,
        Color.ddoPink,
        Color.ddoGreen,
        Color.ddoOrange
    ]
    
    var body: some View {
        // 하단 버튼 있으면 10, 아니면 30
        VStack(spacing: 30){
            
            ArchivingCard(cardText: $cardText, cardData: $cardData, cardOrder: $cardOrder, cardDate: $cardDate, cardColor: $cardColor)
            
            HStack(spacing: 3){
                Button(action: {
                    self.cardColor = self.randomColor()
                }, label: {
                    Text("이전 칭찬")
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 18, leading: 20, bottom: 18, trailing: 20))
                        .background(.black.opacity(0.7))
                        .cornerRadius(15)
                })
                Spacer()
                Button(action: {
                    self.cardColor = self.randomColor()
                }, label: {
                    Text("다음 칭찬")
                        .frame(maxWidth: .infinity)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 18, leading: 20, bottom: 18, trailing: 20))
                        .background(.black.opacity(0.7))
                        .cornerRadius(15)
                })
            }
        }
        .padding()
        .background(Color(hex: 0xF9F9F3))
    }
    
    private func randomColor() -> Color {
        let randomIndex = Int.random(in: 0..<colors.count)
        return colors[randomIndex]
    }
}

struct ArchivingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingDetailView()
    }
}
