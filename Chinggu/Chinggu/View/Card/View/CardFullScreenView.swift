//
//  CardFullScreenView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardFullScreenView: View {
    @StateObject var viewModel = CardFullScreenViewModel()
    @Binding var showPopup: Bool
    var namespace: Namespace.ID
	
    var body: some View {
        ScrollView {
            VStack {
                buildImage
                
                buildCardHeader
                
                ScrollView(.vertical, showsIndicators: false) {
                    buildComplimentList
                }
                
                buildRandomQuote
                
                buildCloseButton
            }
            .foregroundColor(.black)
        }
        .ignoresSafeArea()
        .background(Color.ddoPrimary)
        .matchedGeometryEffect(id: "background", in: namespace)
        .alert(isPresented: $viewModel.showErrorAlert) {
            Alert(title: Text("에러"), message: Text(viewModel.errorDescription), dismissButton: .default(Text("확인")))
        }
    }
    
    private var buildImage: some View {
        Image("gradientPresent")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .matchedGeometryEffect(id: "image", in: namespace)
    }
    private var buildCardHeader: some View {
        HStack {
            Text(viewModel.groupOrderText)
                .font(.headline)
                .matchedGeometryEffect(id: "title", in: namespace)
                .foregroundColor(Color("oll"))
            Text(viewModel.groupStartEndDates)
                .font(.caption)
                .matchedGeometryEffect(id: "subtitle", in: namespace)
                .foregroundColor(.gray)
            Spacer()
        }
        .padding()
    }
    
    private var buildComplimentList: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(viewModel.complimentsInGroup, id: \.id) { compliment in
                Text(compliment.compliment ?? "nil compliment")
                    .font(.system(size: 17, weight: .regular))
                    .padding(.horizontal)
                    .lineSpacing(6)
                Divider()
                    .padding(4)
            }
        }
        .padding()
    }

    private var buildRandomQuote: some View {
        VStack {
            Text(viewModel.randomQuote.text)
            Text(viewModel.randomQuote.speaker)
        }
        .multilineTextAlignment(.center)
        .font(.system(size: 10, weight: .regular))
        .tint(.gray)
    }
    
    private var buildCloseButton: some View {
        HStack {
            Spacer()
            Button {
                viewModel.breakComplimentBox()
                //MainView의 Popup Card를 내림
                withAnimation(.easeOut) {
                    showPopup = false
                }
            } label: {
                Text("닫기")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color.white)
                    .kerning(1)
                    .padding(.vertical,6)
                    .frame(width: UIScreen.main.bounds.width/1.15, height: 56)
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("oll"))
            }
            
            Spacer()
        }
        .padding()
    }
}
