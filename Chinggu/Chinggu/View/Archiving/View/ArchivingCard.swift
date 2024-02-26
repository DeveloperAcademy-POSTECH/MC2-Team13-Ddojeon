//
//  ArchivingCard.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/10.
//

import SwiftUI

struct ArchivingCard: View {

    var compliment: ComplimentEntity
    
    var body: some View {
        VStack {            
            VStack(alignment: .leading){
                Text(compliment.unwrappedCompliment)
                    .font(.body)
                    .fontWeight(.semibold)
					.lineSpacing(CardStyle.cardLineSpacing)
                    .foregroundColor(Color("oll"))
				
                Spacer()
				
                HStack(){
                    Spacer()
                    Text(compliment.unwrappedCreateDate.formatWithDot())
						.opacity(CardStyle.cardDateOpacity)
                        .font(.caption)
                }
            }
			.padding(Metric.cardInsidePadding)
            .background(ColorStyle.randomColor())
            .cornerRadius(CardStyle.cardCornerRadius)
        }
    }
}