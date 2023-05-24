//
//  WriteComplimentView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/08.
//

import SwiftUI

struct WriteComplimentView: View {
	
    @State private var content = ""
    @State private var selection = 0
    @State private var presentSheet = false
    @State private var showingGoBackAlert = false
    @State private var showingSaveAlert = false
    @State private var goBackAlert = SaveAlert(title: "정말로 나갈까요?", description: "작성 중인 내용은 저장되지 않아요")
    @State private var saveAlert = SaveAlert(title: "칭찬을 저장할까요?", description: "칭찬은 하루에 한 번만 쓸 수 있어요")
	
	@FocusState private var isFocused: Bool
	@Environment(\.dismiss) private var dismiss
	@Binding var isCompliment: Bool
	@AppStorage("group") var groupOrder: Int = 1

    let categories: [Category] = Categories.allCases.map { Category(title: $0.title, tipColor: $0.tipColor, sheetColor: $0.sheetColor, example: $0.example) }
	
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Image(systemName: "book.closed.fill")
                    Text("칭찬요정 tip")
                    Spacer()
                }
                .padding()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<categories.count, id: \.self) { idx in
                            Button(action: {
                                selection = idx
                                presentSheet = true
                            }) {
                                Text(categories[idx].title)
                                    .bold()
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(categories[idx].tipColor)
                                    .cornerRadius(10)
									.foregroundColor(Color.ddoText)
                            }
                        }
                    }
                    .padding(.horizontal, 17.0)
                    .padding(.vertical, 4.0)
                    .sheet(isPresented: $presentSheet) {
                        VStack {
                            Text("아래 예시를 참고해서 자유롭게 작성해보세요")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor (Color.primary.opacity (0.30))
                            TabView(selection: $selection) {
                                ForEach(0..<categories.count, id: \.self) { idx in
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text(categories[idx].title)
                                            .font(.system(size: 24, weight: .bold))
                                        Text(categories[idx].example)
                                            .font(.system(size: 17, weight: .regular))
                                            .lineSpacing(7)
                                            .foregroundColor (Color.primary.opacity (0.70))
                                    }
                                    .padding(.leading, 26)
                                    .padding(.trailing, 36)
                                    .padding(.bottom, 6)
                                    .frame(width: 332, height: 225)
                                    .background(categories[idx].sheetColor)
                                    .cornerRadius(16.0)
                                    .tag(idx)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .always))
							.indexViewStyle(.page(backgroundDisplayMode: .never))
                            .padding(EdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16))
                        }
                        .padding(.top, 30)
						.presentationDetents([.fraction(0.4)])
//                        .presentationDetents([.height(300)])
//                        .presentationDragIndicator(.visible)
                    }
                }
                
            }
            
            VStack(spacing: 0) {
				Divider()
                    .padding(.top, 5)
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(height: 5)
                    .opacity(0.15)
                Divider()
            }
            
            ZStack(alignment: .topLeading) {
                let placeholder = "오늘의 칭찬을 자유롭게 작성해보세요"
                if content.isEmpty {
                    Text(placeholder)
                        .lineSpacing(5)
                        .foregroundColor (Color.primary.opacity (0.30))
                        .padding(.top, 24)
                        .padding(.horizontal, 20)
                }
                TextEditor(text: $content)
                    .padding()
                    .lineSpacing(5)
                    .disableAutocorrection(true)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .focused($isFocused)
                    .scrollContentBackground(.hidden)
            }
            
            Spacer()
        }
        .background(Color.ddoPrimary)
        .onTapGesture {
            isFocused = false
        }
        .navigationTitle("칭찬쓰기")
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    guard !content.isEmpty else {
                        return dismiss()
                    }
                    showingGoBackAlert = true
                })
                {
                    HStack {
                        Image(systemName: "chevron.backward")
                    }
                    .foregroundColor(Color.black)
                }
                .alert(goBackAlert.title, isPresented: $showingGoBackAlert, presenting: goBackAlert) {saveAlert in
					Button("나가기", role: .destructive) { dismiss.callAsFunction() }
					Button("취소", role: .cancel) {}
                } message: {article in
                    Text(goBackAlert.description)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장", action: showSaveAlert)
                    .disabled(content.isEmpty ? true : false)
                    .alert(saveAlert.title, isPresented: $showingSaveAlert, presenting: saveAlert) {saveAlert in
                        Button("저장", action: saveContent)
                        Button("취소", role: .cancel) {}
                    } message: {article in
                        Text(saveAlert.description)
                    }
                
            }
            
        }
    }
	
	private struct SaveAlert: Identifiable {
		var id: String { title }
		let title: String
		let description: String
	}

	private func showSaveAlert () {
		showingSaveAlert = true
	}
	
	private func saveContent () {
		PersistenceController.shared.addCompliment(complimentText: content, groupID: Int16(groupOrder))
		dismiss.callAsFunction()
		isCompliment = true
	}

}

struct WriteComplimentView_Previews: PreviewProvider {
    static var previews: some View {
		WriteComplimentView(isCompliment: .constant(true))
    }
}
