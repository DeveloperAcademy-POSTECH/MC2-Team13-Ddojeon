//
//  ArchivingCard.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/10.
//

import SwiftUI

struct ArchivingCard: View {
    
    @Binding var compliment: String
    @Binding var groupID: Int16
    @Binding var order: Int16
    @Binding var createDate: Date
    var cardColor: Color
    
    var body: some View {
        VStack {
            VStack(alignment: .leading){
                HStack(spacing: -5){
                    
                    Text("\(groupID)번째 상자")
                        .foregroundColor(Color("oll"))
                        .opacity(0.9)
                        .scaleEffect(0.9)
                    
                    Text("ㅣ")
                        .opacity(0.9)
                        .scaleEffect(0.9)
                    
                    Text("\(order)번째 칭찬")
                        .foregroundColor(Color("oll"))
                        .opacity(0.9)
                        .scaleEffect(0.9)
                    Spacer()
                }
                .padding(.leading)
            }
            
            VStack(alignment: .leading){
                Text(compliment)
                    .font(.body)
                    .fontWeight(.semibold)
                    .lineSpacing(5)
                    .foregroundColor(Color("oll"))
                Spacer()
                HStack(alignment: .bottom){
                    
                    Spacer()
                    
                    //날짜
                    
                    Text(createDate.formatWithDot())
                        .opacity(0.3)
                        .font(.caption)
                }
            }
            .padding(30)
            .background(cardColor)
            .cornerRadius(30)
        }
    }
}
