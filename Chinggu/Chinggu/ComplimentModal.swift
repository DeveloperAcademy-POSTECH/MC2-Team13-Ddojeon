//
//  ComplimentModal.swift
//  Chinggu
//
//  Created by alex on 2023/05/10.
//

import Foundation
import SwiftUI


struct ComplimentModalView: View {
    @State private var content = ""
    @State private var presentSheet = true
//    @Binding var presentSheet: Bool
    var body: some View {
        Button(action: {
            presentSheet = true
        }, label: {
            Text("🥕 내면")
                .bold()
                .frame(height: 44)
                .padding(.horizontal)
                .background(Color.ddoTip1)
                .cornerRadius(10)
                .foregroundColor(Color.black)
        })
        .sheet(isPresented: $presentSheet) {
            VStack{
                Text("칭찬요정 tip은 작성을 위한 참고 예시에요.").padding(.top)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor (Color.primary.opacity (0.30))
                
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(categories, id: \.self.title, content: { category in
                            VStack(alignment: .leading, spacing: 60) {
                                Text(category.title)
                                    .font(.system(size: 24, weight: .bold))
                                Text(category.example)
                                    .font(.system(size: 17, weight: .regular))
                                    .lineSpacing(7)
                                    .foregroundColor (Color.primary.opacity (0.70))
                            }
                            .padding(.leading, 26)
                            .padding(.trailing, 26)
                            .padding(.bottom, 6)
                            .frame(width: 312, height: 253)
                            .background(category.sheetColor)
                            .foregroundColor(.black)
                            .cornerRadius(16.0)
                        })
                    }
                    .padding(24)
                }
            }
            .padding(.top, 10)
            .presentationDetents([.height(357)])

//            .presentationCornerRadius(24)
        }
    }
}

//        .presentationDragIndicator(.hidden)



struct ComplimentModalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ComplimentModalView()
        }
    }
}




