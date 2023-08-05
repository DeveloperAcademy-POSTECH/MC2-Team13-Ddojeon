////
////  TempMainView.swift
////  Chinggu
////
////  Created by Junyoo on 2023/05/05.
////
//
//import SwiftUI
//import CoreData
//
//struct TempMainView: View {
//	
//	@FetchRequest(
//		entity: ComplimentEntity.entity(),
//		sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)])
//	var Compliment: FetchedResults<ComplimentEntity>
//	@AppStorage("group") var groupOrder: Int = 1
//	@AppStorage("isfirst") var isfirst: Bool = false
//    @AppStorage("isCompliment") private var isCompliment: Bool = false
//	@State private var textFieldTitle: String = ""
//	@State private var showPopup = false
//	@State private var customDate = Date()
//
//	var body: some View {
//		ZStack {
//			Color.ddoPrimary.ignoresSafeArea()
//			VStack {
//				VStack(spacing: 10) {
//					Spacer()
//					HStack {
//						TextField("", text: $textFieldTitle)
//							.padding()
//							.frame(maxWidth: .infinity)
//							.background(Color(UIColor.secondarySystemBackground).cornerRadius(10))
//						.padding(.horizontal, 10)
//						DatePicker("",
//							selection: $customDate,
//							displayedComponents: [.date]
//						)
//						.padding()
//						.background(.yellow)
//						.cornerRadius(15)
//						.padding()
//					}
//					.frame(height: 55)
//					
//					Button {
//						addCustomCompliment(complimentText: textFieldTitle, groupID: Int16(groupOrder))
//					} label: {
//						Text("해당 날짜에 칭찬 넣기")
//							.padding()
//							.frame(maxWidth: .infinity)
//							.frame(height: 55)
//							.foregroundColor(.black)
//							.background(Color.yellow.cornerRadius(10))
//							.padding(.horizontal, 10)
//					}
//					
//					HStack {
//						Button {
//							UserDefaults.standard.set(false, forKey: UserDefaultsKeys.hasOnboarded)
//						} label: {
//							Text("재시작시 온보딩")
//								.padding()
//								.frame(maxWidth: .infinity)
//								.frame(height: 55)
//								.foregroundColor(.black)
//								.background(Color.yellow.cornerRadius(10))
//								.padding(.horizontal, 10)
//						}
//						Button {
//							groupOrder = groupOrder + 1
//						} label: {
//							Text("상자 빠르게 열기")
//								.padding()
//								.frame(maxWidth: .infinity)
//								.frame(height: 55)
//								.foregroundColor(.black)
//								.background(Color.yellow.cornerRadius(10))
//								.padding(.horizontal, 10)
//						}
//					}
//					HStack {
//						Button {
//							PersistenceController.shared.deleteAllCompliments()
//							isfirst = true
//                            isCompliment = false
//						} label: {
//							Text("칭찬 초기화")
//								.padding()
//								.frame(maxWidth: .infinity)
//								.frame(height: 55)
//								.foregroundColor(.black)
//								.background(Color.yellow.cornerRadius(10))
//								.padding(.horizontal, 10)
//						}
//						Button {
//							groupOrder = 1
//						} label: {
//							Text("상자값 초기화")
//								.padding()
//								.frame(maxWidth: .infinity)
//								.frame(height: 55)
//								.foregroundColor(.black)
//								.background(Color.yellow.cornerRadius(10))
//								.padding(.horizontal, 10)
//						}
//					}
//					List {
//						ForEach((1..<$groupOrder.wrappedValue).reversed(), id: \.self) { index in
//								Section(header: Text("\(index)번째 상자")) {
//									ForEach(Compliment, id: \.self.id) { compliments in
//										if compliments.groupID == index {
//											let currentDate = compliments.createDate
//											let strDate = currentDate?.formatWithDot()
//											let id = compliments.order
//											HStack {
//												Text(compliments.compliment ?? "empty")
//												Text(strDate ?? "timeerror")
//												Text("| 칭찬 No.\(id)")
//												Text("| 상자 No.\(compliments.groupID)")
//											}
//										} else { }
//									}
//									.onDelete(perform: delete)
//
//							}
//						}
//					}
//					.scrollContentBackground(.hidden)
//				}
//			}
//			.blur(radius: showPopup ? 3 : 0)
//			.disabled(showPopup)
//			.popup(isPresented: $showPopup) {
//				CardView(showPopup: $showPopup)
//			}
//		}
//	}
//	
//	private func addCustomCompliment(complimentText: String, groupID: Int16) {
//		let viewContext = PersistenceController.shared.container.viewContext
//		let compliment = ComplimentEntity(context: viewContext)
//		compliment.compliment = complimentText
//		compliment.createDate = customDate
//		compliment.order = fetchLatestOrder() + 1
//		compliment.id = UUID()
//		compliment.groupID = groupID
//		textFieldTitle = ""
//
//		do {
//			try viewContext.save()
//		} catch {
//			print("\(error)")
//			viewContext.rollback()
//		}
//	}
//
//	private func fetchLatestOrder() -> Int16 {
//		let fetchRequest: NSFetchRequest<ComplimentEntity> = ComplimentEntity.fetchRequest()
//		fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
//		fetchRequest.fetchLimit = 1
//
//		do {
//			let viewContext = PersistenceController.shared.container.viewContext
//			let lastCompliment = try viewContext.fetch(fetchRequest).first
//			return lastCompliment?.order ?? 0
//		} catch {
//			print("\(error)")
//			return 0
//		}
//	}
//	
//	private func add() {
//		PersistenceController.shared.addCompliment(complimentText: textFieldTitle, groupID: Int16(groupOrder))
//		textFieldTitle = ""
//	}
//	
//	private func delete(indexset: IndexSet) {
//		guard let index = indexset.first else { return }
//		let selectedEntity = Compliment[index]
//		PersistenceController.shared.deleteCompliment(compliment: selectedEntity)
//	}
//}
