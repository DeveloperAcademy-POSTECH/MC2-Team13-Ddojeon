//
//  CardFullScreenView.swift
//  mc2Test
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardFullScreenView: View {
	
	var namespace: Namespace.ID
	@Binding var show: Bool
	
	var body: some View {
		ScrollView {
			VStack {
				Image("present")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.matchedGeometryEffect(id: "image", in: namespace)
				Text("11번째 저금통 2023.05.01 ~ 2023.05.08")
					.font(.footnote)
					.matchedGeometryEffect(id: "title", in: namespace)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
				List {
					Text("diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd")
						.listRowBackground(Color.red)
						.font(.footnote)
						.matchedGeometryEffect(id: "text1", in: namespace)
					Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's")
						.listRowBackground(Color.orange)
						.font(.footnote)
						.matchedGeometryEffect(id: "text2", in: namespace)
					Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's")
						.listRowBackground(Color.yellow)
						.font(.footnote)
						.matchedGeometryEffect(id: "text3", in: namespace)
					Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's")
						.listRowBackground(Color.green)
						.font(.footnote)
						.matchedGeometryEffect(id: "text4", in: namespace)
					Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's")
						.listRowBackground(Color.blue)
						.font(.footnote)
						.matchedGeometryEffect(id: "text5", in: namespace)
					Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's")
						.listRowBackground(Color.purple)
						.font(.footnote)
						.matchedGeometryEffect(id: "text6", in: namespace)
					Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's")
						.listRowBackground(Color.white)
						.font(.footnote)
						.matchedGeometryEffect(id: "text7", in: namespace)
				}
				.padding(.top, -20)
				.scrollContentBackground(.hidden)
				.scaledToFit()
				HStack {
					Spacer()
					Button {
						withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
							show.toggle()
						}
					} label: {
						Text("나가기 버튼")
							.font(.title)
							.foregroundColor(.white)
							.padding()
					}
					.background {
						RoundedRectangle(cornerRadius: 15)
							.foregroundColor(.blue)
					}

					Spacer()
				}
				.padding()
			}
			.foregroundColor(.black)
		}
//		.ignoresSafeArea()
		.background(Color.ddoPrimary)
		.matchedGeometryEffect(id: "background", in: namespace)
	}
}

struct CardFullScreenView_Previews: PreviewProvider {
	
	@Namespace static var namespace
	
    static var previews: some View {
		CardFullScreenView(namespace: namespace, show: .constant(true))
    }
}
