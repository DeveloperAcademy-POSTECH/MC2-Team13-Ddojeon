//
//  TempMainView.swift
//  Chinggu
//
//  Created by Junyoo on 2023/05/05.
//

import SwiftUI
import CoreData

struct TempMainView: View {
	
	@Environment(\.managedObjectContext) private var viewContext
	@State private var showPopup = false
	@FetchRequest(
		entity: ComplimentEntity.entity(),
		sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.createDate, ascending: true)])
	var Compliment: FetchedResults<ComplimentEntity>
	
	@State var textFieldTitle: String = ""
	
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
					
					Button(action: {addItem()}, label: {
						Text("저장")
							.padding()
							.frame(maxWidth: .infinity)
							.frame(height: 55)
							.foregroundColor(.black)
							.background(Color.yellow.cornerRadius(10))
							.padding(.horizontal, 10)
						
					})
					List {
						ForEach(Compliment) { compliments in
							let currentDate = compliments.createDate
							let strDate = currentDate?.formatWithDot()
							let id = compliments.id?.uuidString
							HStack {
								Text(compliments.compliment ?? "empty")
								Text(strDate ?? "timeerror")
								Text(id ?? "iderror")
							}
//							.listRowBackground(Color.blue)
						}
						.onDelete(perform: deleteItems)
					}
					.scrollContentBackground(.hidden)
				Button("저금통 깨기") {
					showPopup = true
				}
			}
		}
		.popup(isPresented: $showPopup) {
			ZStack {
				CardView()
			}
		}
		}
	}
	
	private func updateItems(compliment: ComplimentEntity) {
		let currentCompliment = compliment.compliment ?? ""
		let newCompliment = currentCompliment + "!"
		compliment.compliment = newCompliment
		saveItems()
	}
	
	private func addItem() {
		withAnimation {
			//수정 부분
			let newCompliment = ComplimentEntity(context: viewContext)
			newCompliment.compliment = textFieldTitle
			newCompliment.createDate = Date()
			newCompliment.id = UUID()
			//textFieldTitle을 사용 후 재설정
			textFieldTitle = ""
			
			saveItems()
		}
	}
	
	private func deleteItems(offsets: IndexSet) {
		withAnimation {
			
			guard let index = offsets.first else { return }
			let MessageEntity = Compliment[index]
			viewContext.delete(MessageEntity)
			saveItems()
		}
	}
	
	private func saveItems() {
		do {
			try viewContext.save()
		} catch {
			let nsError = error as NSError
			fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
		}
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
					.offset(y: popupOffset)
					.onAppear {
						withAnimation(.spring()) {
							popupOffset = 0
						}
					}
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

struct TempMainView_Previews: PreviewProvider {
    static var previews: some View {
        TempMainView()
			.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
