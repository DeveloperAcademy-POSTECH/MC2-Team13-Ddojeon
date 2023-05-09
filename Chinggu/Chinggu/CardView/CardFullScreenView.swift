//
//  CardFullScreenView.swift
//  mc2Test
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI

struct CardFullScreenView: View {
	
	@FetchRequest(
		entity: ComplimentEntity.entity(),
		sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)])
	var Compliment: FetchedResults<ComplimentEntity>
	var namespace: Namespace.ID
	@Binding var showPopup: Bool

	var body: some View {
		ScrollView {
			VStack {
				Image("gradientPresent")
					.resizable()
					.aspectRatio(contentMode: .fill)
					.matchedGeometryEffect(id: "image", in: namespace)
				Text("11번째 저금통 2023.05.01 ~ 2023.05.08")
					.font(.footnote)
					.matchedGeometryEffect(id: "title", in: namespace)
					.frame(maxWidth: .infinity, alignment: .leading)
					.padding()
				ScrollView(.vertical, showsIndicators: false) {
					VStack(alignment: .leading, spacing: 10) {
						ForEach(Compliment) { compliments in
							Text(compliments.compliment ?? "nil compliment")
							.padding(.leading)
							Divider()
						}
					}
					.padding()
				}
				HStack {
					Spacer()
					Button {
						withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
							//MainView의 Popup Card를 내림
							showPopup = false
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
		.ignoresSafeArea()
		.background(Color.ddoPrimary)
		.matchedGeometryEffect(id: "background", in: namespace)
	}
}

struct CardFullScreenView_Previews: PreviewProvider {
	
	@Namespace static var namespace
	
    static var previews: some View {
		CardFullScreenView(namespace: namespace, showPopup: .constant(true))
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
