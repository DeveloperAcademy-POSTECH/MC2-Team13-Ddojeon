//
//  ArchivingCard.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/10.
//

import SwiftUI
import Combine

struct ArchivingCard: View {
    
    @Binding var cardText: String
    @Binding var cardData: String
    @Binding var cardOrder: String
    @Binding var cardDate: String
    @Binding var cardColor: Color
    
    var body: some View {

        VStack(alignment: .leading){
            Text(cardText)
                .font(.body)
                .fontWeight(.semibold)
                .lineSpacing(5)
                .foregroundColor(.white)
            Spacer()
            HStack{
                Text(cardData)
                    .padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .background(.black.opacity(0.2))
                    .cornerRadius(5)
                Spacer()
                Text(cardDate)
                    .opacity(0.3)
                Spacer()
                Text(cardOrder)
                    .padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
                    .foregroundColor(.white)
                    .fontWeight(.heavy)
                    .background(.black.opacity(0.2))
                    .cornerRadius(20)
            }
        }
        .padding(30)
        .background(cardColor)
        .cornerRadius(30)
    }
}
