//
//  WriteComplimentView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/08.
//

import SwiftUI


struct WriteComplimentView: View {
    @State private var content = ""
    @FocusState private var isFocused: Bool
    @Environment(\.presentationMode) private var presentationMode
    @State private var showingAlert = false
    @State private var saveAlert = SaveAlert(title: "정말로 나가시겠어요?", description: "작성된 내용은 저장되지 않습니다.")
    
    struct SaveAlert: Identifiable {
        var id: String { title }
        let title: String
        let description: String
    }
    
    struct Category {
        var title: String
        var color: Color
        
        init(title: String, color: Color) {
            self.title = title
            self.color = color
        }
    }
    
    struct SaveDetails: Identifiable {
        let name: String
        let error: String
        let id = UUID()
    }
    
    let categories: [Category] = [Category.init(title: "🥕 내면", color: Color.ddoTip1),
                                  Category.init(title: "🐽 외모", color: Color.ddoTip2),
                                  Category.init(title: "💛 긍정적인 태도", color: Color.ddoTip3),
                                  Category.init(title: "🍎 색다른 발상", color: Color.ddoTip4),
                                  Category.init(title: "🥑 감성", color: Color.ddoTip5),
                                  Category.init(title: "🏃‍♀️ 노력한 과정", color: Color.ddoTip6),
                                  Category.init(title: "💌 과거의 자신", color: Color.ddoTip7),
                                  Category.init(title: "🥺 유혹을 참은 것", color: Color.ddoTip8),
                                  Category.init(title: "🔥 행동", color: Color.ddoTip9),
                                  Category.init(title: "🌊 내적 깨달음", color: Color.ddoTip10)]
    
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
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self.title, content: { category in
                            Button(action: {
                            }) {
                                Text(category.title)
                                    .bold()
                                    .frame(height: 44)
                                    .padding(.horizontal)
                                    .background(category.color)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.black)
                            }
                        })
                    }
                    .padding([.horizontal])
                }
            }
            VStack(spacing: 0) {
                Divider()
                    .padding(.top, 5)
                Rectangle()
                    .fill(Color(.systemGray3))
                    .frame(height: 10)
                    .opacity(0.15)
                Divider()
            }
            
            ZStack(alignment: .topLeading) {
                let placeholder = "오늘의 칭찬을 자유롭게 작성해보세요."
                TextEditor(text: $content)
                    .padding()
                    .lineSpacing(5)
                    .disableAutocorrection(true)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    .focused($isFocused)
                    .scrollContentBackground(.hidden)
                if content.isEmpty{
                    Text(placeholder)
                    .lineSpacing(5)
                    .foregroundColor (Color.primary.opacity (0.30))
                    .padding(.top, 24)
                    .padding(.horizontal, 20)
                }
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
                    if content.isEmpty {
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        showingAlert = true
                    }
                }) {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("뒤로")
                    }
                    .foregroundColor(Color.black)
                }
                .alert(saveAlert.title, isPresented: $showingAlert, presenting: saveAlert) {saveAlert in
                    Button("네") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    Button("취소", role: .cancel) {}
                } message: {article in
                    Text(saveAlert.description)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장") {
                    presentationMode.wrappedValue.dismiss()
                }.disabled(content.isEmpty ? true : false)
            }
            
        }
    }
}

struct WriteComplimentView_Previews: PreviewProvider {
    static var previews: some View {
        WriteComplimentView()
    }
}
