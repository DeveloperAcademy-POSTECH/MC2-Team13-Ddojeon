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

		VStack(alignment: .leading){
			Text(compliment)
				.font(.body)
				.fontWeight(.semibold)
				.lineSpacing(5)
				.foregroundColor(Color("oll"))
			Spacer()
            HStack(alignment: .bottom){
                
                VStack(alignment:.trailing){
                    HStack{
                        Text("\(groupID)")
                            .padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .background(.black.opacity(0.15))
                            .cornerRadius(5)
                        Text("번째 상자")
                            .opacity(0.5)
                            .scaleEffect(0.9)
                            .padding(.leading,-5)
                    }
                    
                    HStack{
                        Text("\(order)")
                            .padding(EdgeInsets(top: 4.5, leading: 7, bottom: 4.5, trailing: 7))
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .background(.black.opacity(0.15))
                            .cornerRadius(5)
                        Text("번째 칭찬")
                            .opacity(0.5)
                            .scaleEffect(0.9)
                            .padding(.leading,-5)
                    }
                    
                }
                
				Spacer()
                
                //날짜
              
                Text(createDate.formatWithDot())
                        .opacity(0.3)
			}
		}
		.padding(30)
		.background(cardColor)
		.cornerRadius(30)
	}
}
