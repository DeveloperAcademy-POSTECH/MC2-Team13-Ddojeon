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
                Text(compliment)
                    .font(.body)
                    .fontWeight(.semibold)
					.lineSpacing(CardStyle.cardLineSpacing)
                    .foregroundColor(Color("oll"))
				
                Spacer()
				
                HStack(){
                    Spacer()
                    //날짜
                    Text(createDate.formatWithDot())
						.opacity(CardStyle.cardDateOpacity)
                        .font(.caption)
                }
            }
			.padding(Metric.cardInsidePadding)
            .background(cardColor)
			.cornerRadius(CardStyle.cardCornerRadius)
        }
    }
}
