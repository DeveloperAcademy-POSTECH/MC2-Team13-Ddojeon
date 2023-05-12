//
//  TempMainView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI
import CoreData

struct TempMainView: View {
	
	//CoreData의 데이터를 읽어오기 위해 필요해요
	@FetchRequest(
		entity: ComplimentEntity.entity(),
		sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)])
	var Compliment: FetchedResults<ComplimentEntity>
	@AppStorage("group") var groupOrder: Int = UserDefaults.standard.integer(forKey: "orderID")

	@State private var textFieldTitle: String = ""
	@State private var showPopup = false

	var body: some View {
		ZStack {
			Color.ddoPrimary.ignoresSafeArea()
			VStack {
				HStack {
					Spacer()
					Image(systemName: "captions.bubble.fill").padding()
				}
				VStack(spacing: 10) {
					TextField("", text: $textFieldTitle)
						.padding()
						.frame(maxWidth: .infinity)
						.frame(height: 55)
						.background(Color(UIColor.secondarySystemBackground).cornerRadius(10))
						.padding(.horizontal, 10)
					
					Button(action: {add()}, label: {
						Text("저장")
							.padding()
							.frame(maxWidth: .infinity)
							.frame(height: 55)
							.foregroundColor(.black)
							.background(Color.yellow.cornerRadius(10))
							.padding(.horizontal, 10)
						
					})
					HStack {
						Button(action: { groupOrder = groupOrder + 1 }, label: {
							Text("countup group")
								.padding()
								.frame(maxWidth: .infinity)
								.frame(height: 55)
								.foregroundColor(.black)
								.background(Color.yellow.cornerRadius(10))
								.padding(.horizontal, 10)
							
						})
						Button(action: { groupOrder = 0 }, label: {
							Text("group 초기화")
								.padding()
								.frame(maxWidth: .infinity)
								.frame(height: 55)
								.foregroundColor(.black)
								.background(Color.yellow.cornerRadius(10))
								.padding(.horizontal, 10)
							
						})
					}
					List {
						ForEach((0..<$groupOrder.wrappedValue).reversed(), id: \.self) { index in
								Section(header: Text("\(index)번째 저금통")) {
									ForEach(Compliment, id: \.self.id) { compliments in
										if compliments.groupID == index {
											let currentDate = compliments.createDate
											let strDate = currentDate?.formatWithDot()
											let id = compliments.order
											HStack {
												Text(compliments.compliment ?? "empty")
												Text(strDate ?? "timeerror")
												Text("\(id)")
												Text("\(compliments.groupID)")
											}
										} else { }
									}
									.onDelete(perform: delete)

							}
						}
					}
					.scrollContentBackground(.hidden)
					Button("저금통 깨기") {
						showPopup = true
					}
				}
			}
			.blur(radius: showPopup ? 3 : 0)
			.disabled(showPopup)
			.popup(isPresented: $showPopup) {
				CardView(showPopup: $showPopup)
			}
		}
	}
	
	//데이터 넣을때 이렇게 하세요 String값만 주면됩니다
	private func add() {
		PersistenceController.shared.addCompliment(complimentText: textFieldTitle, groupID: Int16(groupOrder))
		textFieldTitle = ""
	}
	
	//onDelete에 넣어주시면 indexset넣어줄거 없이 알아서 처리해줘요
	private func delete(indexset: IndexSet) {
		guard let index = indexset.first else { return }
		let selectedEntity = Compliment[index]
		PersistenceController.shared.deleteCompliment(compliment: selectedEntity)
	}
}

struct Popup<PopupContent: View>: ViewModifier {
	
	@Binding var isPresented: Bool
	let view: () -> PopupContent
	@State private var popupOffset: CGFloat = UIScreen.main.bounds.height

	func body(content: Content) -> some View {
		ZStack {
			content
			if isPresented {
				view()
					.transition(AnyTransition.scale.animation(.easeInOut).combined(with: .opacity))
			}
		}
	}
}

extension View {

	public func popup<PopupContent: View>(
		isPresented: Binding<Bool>,
		view: @escaping () -> PopupContent) -> some View {
		self.modifier(
			Popup(
				isPresented: isPresented,
				view: view)
		)
	}
}

//struct TempMainView_Previews: PreviewProvider {
//    static var previews: some View {
//        TempMainView()
//			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
