//
//  TipSheet.swift
//  Chinggu
//
//  Created by chaekie on 2023/09/07.
//

import SwiftUI

struct TipSheetView: View {
    let categories: [Category]
    @State private var selection = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                TipSheetBackgroundImage(geometry: geometry)
                VStack {
                    tipList
                    exampleText
                    Spacer()
                    footNote
                }
            }
            .presentationDetents([.fraction(0.45)])
        }
        .padding(.top, 30)
    }

    private var tipList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<categories.count, id: \.self) { idx in
                    TipButton(idx: idx, selection: $selection, categories: categories)
                }
            }
            .padding(.horizontal, 17.0)
        }
    }

    private var exampleText: some View {
        Text(categories[selection].example)
            .font(.title3)
            .lineSpacing(10)
            .fontWeight(.semibold)
            .foregroundColor(Color(.systemBrown))
            .multilineTextAlignment(.center)
            .padding()
            .padding(.top, 20)
    }

    private var footNote: some View {
        HStack {
            Image(systemName: "info.circle")
            Text("칭찬은 언제나 가까이 있어요")
        }
        .font(.footnote)
        .foregroundColor (Color.primary.opacity (0.30))
        .padding(.bottom, 20)
    }
}

struct TipSheetBackgroundImage: View {
    var geometry: GeometryProxy
    var body: some View {
        Image("tipSheet")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: geometry.size.width, height: geometry.size.height)
    }
}

struct TipButton : View {
    var idx: Int
    @Binding var selection: Int
    var categories: [Category]

    var body: some View {
        Button(action: {
            selection = idx
        }) {
            Text(categories[idx].title)
                .bold()
                .frame(height: 44)
                .padding(.horizontal)
                .background(idx == selection ? .black : Color(.systemGray6))
                .cornerRadius(10)
                .foregroundColor(idx == selection ? .white : .black)
        }
    }
}

struct TipSheetView_Previews: PreviewProvider {
    static var previews: some View {
        let categories: [Category] = Categories.allCases.map { Category(title: $0.title, example: $0.example)}
        TipSheetView(categories: categories)
    }
}
