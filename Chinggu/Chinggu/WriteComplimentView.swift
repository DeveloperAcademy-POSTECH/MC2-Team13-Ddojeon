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
    @Environment(\.dismiss) private var dismiss
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
    
    enum Categories: CaseIterable {
        case innerSelf
        case appearance
        case positiveAttiude
        case freshIdea
        case emotion
        case theProcessOfEffort
        case pastSelf
        case resistingTemptation
        case action
        case innerRealization
        
        var title: String {
            switch self {
            case .innerSelf: return "🥕 내면"
            case .appearance: return "🐽 외모"
            case .positiveAttiude: return "💛 긍정적인 태도"
            case .freshIdea: return "🍎 색다른 발상"
            case .emotion: return "🥑 감성"
            case .theProcessOfEffort: return "🏃‍♀️ 노력한 과정"
            case .pastSelf: return "💌 과거의 자신"
            case .resistingTemptation: return "🥺 유혹을 참은 것"
            case .action: return "🔥 행동"
            case .innerRealization: return "🌊 내적 깨달음"
            }
        }
        
        var color: Color {
            switch self {
            case .innerSelf: return Color.ddoTip1
            case .appearance: return Color.ddoTip2
            case .positiveAttiude: return Color.ddoTip3
            case .freshIdea: return Color.ddoTip4
            case .emotion: return Color.ddoTip5
            case .theProcessOfEffort: return Color.ddoTip6
            case .pastSelf: return Color.ddoTip7
            case .resistingTemptation: return Color.ddoTip8
            case .action: return Color.ddoTip9
            case .innerRealization: return Color.ddoTip10
            }
        }
    }
    
    let categories: [Category] = Categories.allCases.map { Category(title: $0.title, color: $0.color) }
    
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
                    showingAlert = true
                })
                {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("뒤로")
                    }
                    .foregroundColor(Color.black)
                }
                .alert(saveAlert.title, isPresented: $showingAlert, presenting: saveAlert) {saveAlert in
                    Button("네", action: dismiss.callAsFunction)
                    Button("취소", role: .cancel) {}
                } message: {article in
                    Text(saveAlert.description)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장", action: dismiss.callAsFunction)
                    .disabled(content.isEmpty ? true : false)
            }
            
        }
    }
}

struct WriteComplimentView_Previews: PreviewProvider {
    static var previews: some View {
        WriteComplimentView()
    }
}
