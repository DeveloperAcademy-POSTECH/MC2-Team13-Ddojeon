//
//  WriteComplimentView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/08.
//

import SwiftUI

struct Category {
    var title: String
    var tipColor: Color
    var sheetColor: Color
    var example: String
    
    init(title: String, tipColor: Color, sheetColor: Color, example: String) {
        self.title = title
        self.tipColor = tipColor
        self.sheetColor = sheetColor
        self.example = example
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
    
    var tipColor: Color {
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
    
    var sheetColor: Color {
        switch self {
        case .innerSelf: return Color.ddoSheet1
        case .appearance: return Color.ddoSheet2
        case .positiveAttiude: return Color.ddoSheet3
        case .freshIdea: return Color.ddoSheet4
        case .emotion: return Color.ddoSheet5
        case .theProcessOfEffort: return Color.ddoSheet6
        case .pastSelf: return Color.ddoSheet7
        case .resistingTemptation: return Color.ddoSheet8
        case .action: return Color.ddoSheet9
        case .innerRealization: return Color.ddoSheet10
        }
    }
    
    
    var example: String {
        switch self {
        case .innerSelf: return "회사에서 실수를 해서 지적받았지만 바로 원래의 나로 돌아올 수 있었다.요즘에는 기가 죽는 일을 겪어도 빨리 회복한다. 제대로 잘하고 있어!"
        case .appearance: return "매번 바뀌는 미의 기준을 나는 상관하지\n않는다. 충분히 건강하고 자신감 넘치는 내가 멋지다. 아무거나 입어도 옷이 잘 어울리는 내 몸이 난 좋다."
        case .positiveAttiude: return "\n매일 오후 1시에 일어났는데 오늘은 11시에 일어났다. 나만의 미라클 모닝에 가까워지고 있어서 뿌듯하다."
        case .freshIdea: return "예전에는 취업에 실패하면 내 자신을 탓했지만 지금은 나와 맞는 회사가 있을거라는 믿음이 있다. 이렇게 긍정적으로 변화한 내가 대견하다."
        case .emotion: return "오늘 노을이 너무 예뻐서 사진을 찍었다. 자연의 아름다움을 느끼고 순간을 만끽할 줄 아는 나의 감수성이 멋있다."
        case .theProcessOfEffort: return "\n그간 나에게 칭찬하기를 못했지만, 포기하지 않고 스스로의 돌봄을 시작한 내 의지력과 실천에 박수치고 싶다."
        case .pastSelf: return "대학교 때 주변의 만류에도 불구하고, 내가 진정 하고싶은 일을 위해 학교를 그만두게 되었다. 과감한 결정을 내린 나는 주체적이고 용감한 사람이다."
        case .resistingTemptation: return "1. 근 일주일동안 택시를 세 번만 탔다. 지출 줄이기 목표에 다가가고 있다. 2. 오늘 손톱을 물어뜯지 않았다. 정말 열심히 꾹 참은 내가 대단하다."
        case .action: return "\n1. 오늘도 도서관에 왔다. 잘하고 있어! 2. 예전부터 참아왔던 말을 드디어 했다. 내 자신이 정말 장하다."
        case .innerRealization: return "타인의 의견을 무조건 수용하는 방식이 좋은 결과와 비례하지 않다는걸 느꼈다. 의견을 분별해 수용할 수 있는 판단력을 기른 것 같아 기쁘다."
        }
    }
}

let categories: [Category] = Categories.allCases.map { Category(title: $0.title, tipColor: $0.tipColor, sheetColor: $0.sheetColor, example: $0.example) }


struct WriteComplimentView: View {
    @State private var content = ""
    @State private var selection = 0
    @State private var presentSheet = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var showingAlert = false
    @State private var saveAlert = SaveAlert(title: "정말로 나가시겠어요?", description: "작성된 내용은 저장되지 않습니다.")
    
    func saveContent () {
        dismiss.callAsFunction()
    }
    
    struct SaveAlert: Identifiable {
        var id: String { title }
        let title: String
        let description: String
    }
    
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
                        ForEach(categories.indices) { idx in
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
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                    .padding()
                    .sheet(isPresented: $presentSheet) {
                        VStack {
                            Text("칭찬요정 tip은 작성을 위한 참고 예시에요.").padding(.top)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor (Color.primary.opacity (0.30))
                            Spacer()
                            
                            TabView(selection: $selection) {
                                ForEach(categories.indices) { idx in
                                    VStack(alignment: .leading, spacing: 60) {
                                        Text(categories[idx].title)
                                            .font(.system(size: 24, weight: .bold))
                                        Text(categories[idx].example)
                                            .font(.system(size: 17, weight: .regular))
                                            .lineSpacing(7)
                                            .foregroundColor (Color.primary.opacity (0.70))
                                    }
                                    .padding(.leading, 26)
                                    .padding(.trailing, 26)
                                    .padding(.bottom, 6)
                                    .frame(width: 312, height: 253)
                                    .background(categories[idx].sheetColor)
                                    .foregroundColor(.black)
                                    .cornerRadius(16.0)
                                    .tag(idx)
                                }
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never))
//                            .overlay(Button(action: {
//                                withAnimation {
//                                    if selection > 1 {
//                                        selection -= 1
//                                    }
//                                }
//                            }, label: {
//                                if selection != 0 {
//                                    Image(systemName: "chevron.left")
//                                        .foregroundColor(Color.black)
//                                        .font(.title)
//                                        .padding(.leading, 8)
//                                }
//                            }), alignment: .leading)
//                            .overlay(Button(action: {
//                                withAnimation {
//                                    if selection < categories.count - 1 {
//                                        selection += 1
//                                    }
//                                }
//                            }, label: {
//                                if selection != categories.count {
//                                    Image(systemName: "chevron.right")
//                                        .foregroundColor(Color.black)
//                                        .font(.title)
//                                        .padding(.trailing, 8)
//                                }
//                            }), alignment: .trailing)
                        }
                        .padding(.top, 10)
                        .presentationDetents([.height(357)]) // [.small] ?
                        .presentationDragIndicator(.visible)
                    }
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
                Button("저장", action: saveContent)
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
