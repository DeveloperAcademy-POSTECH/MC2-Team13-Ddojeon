//
//  WriteComplimentView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/08.
//

import SwiftUI

struct Category {
    var id = UUID()
    var title: String
    var example: String
    
    init(title: String, example: String) {
        self.title = title
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
        case .innerSelf: return "내면"
        case .appearance: return "외모"
        case .positiveAttiude: return "긍정적인 태도"
        case .freshIdea: return "색다른 발상"
        case .emotion: return "감성"
        case .theProcessOfEffort: return "노력한 과정"
        case .pastSelf: return "과거의 자신"
        case .resistingTemptation: return "유혹을 참은 것"
        case .action: return "행동"
        case .innerRealization: return "내적 깨달음"
        }
    }
    
    var example: String {
        switch self {
        case .innerSelf: return "회사에서 실수를 해서 지적받았지만 바로 원래의 나로 돌아올 수 있었다. 요즘에는 기가 죽는 일을 겪어도 빨리 회복한다. 제대로 잘하고 있어!"
        case .appearance: return "매번 바뀌는 미의 기준을 나는 상관하지 않는다. 충분히 건강하고 자신감 넘치는 내가 멋지다. 아무거나 입어도 옷이 잘 어울리는 내 몸이 난 좋다."
        case .positiveAttiude: return "매일 오후 1시에 일어났는데 오늘은 11시에 일어났다. 나만의 미라클 모닝에 가까워지고 있어서 뿌듯하다."
        case .freshIdea: return "예전에는 취업에 실패하면 내 자신을 탓했지만 지금은 나와 맞는 회사가 있을거라는 믿음이 있다. 이렇게 긍정적으로 변화한 내가 대견하다."
        case .emotion: return "오늘 노을이 너무 예뻐서 사진을 찍었다. 자연의 아름다움을 느끼고 순간을 만끽할 줄 아는 나의 감수성이 멋있다."
        case .theProcessOfEffort: return "그간 나에게 칭찬하기를 못했지만, 포기하지 않고 스스로의 돌봄을 시작한 내 의지력과 실천에 박수치고 싶다."
        case .pastSelf: return "대학교 때 주변의 만류에도 불구하고, 내가 진정 하고싶은 일을 위해 학교를 그만두게 되었다. 과감한 결정을 내린 나는 주체적이고 용감한 사람이다."
        case .resistingTemptation: return "1. 근 일주일동안 택시를 세 번만 탔다. 지출 줄이기 목표에 다가가고 있다.\n2. 오늘 손톱을 물어뜯지 않았다. 정말 열심히 꾹 참은 내가 대단하다."
        case .action: return "\n1. 오늘도 도서관에 왔다. 잘하고 있어!\n2. 예전부터 참아왔던 말을 드디어 했다. 내 자신이 정말 장하다."
        case .innerRealization: return "타인의 의견을 무조건 수용하는 방식이 좋은 결과와 비례하지 않다는걸 느꼈다. 의견을 분별해 수용할 수 있는 판단력을 기른 것 같아 기쁘다."
        }
    }
}



struct WriteComplimentView: View {
    @State private var content = ""
    @State private var selection = 0
    @State private var presentSheet = false
    @FocusState private var isFocused: Bool
    @Environment(\.dismiss) private var dismiss
    @State private var showingGoBackAlert = false
    @State private var showingSaveAlert = false
    @State private var goBackAlert = SaveAlert(title: "정말로 나갈까요?", description: "작성 중인 내용은 저장되지 않아요")
    @State private var saveAlert = SaveAlert(title: "칭찬을 저장할까요?", description: "칭찬은 하루에 한 번만 쓸 수 있어요")
    
    let categories: [Category] = Categories.allCases.map { Category(title: $0.title, example: $0.example) }
    
    @AppStorage("group") var groupOrder: Int = 1
    
    @Binding var isCompliment: Bool
    
    func showSaveAlert () {
        showingSaveAlert = true
    }
    
    func saveContent () {
        PersistenceController.shared.addCompliment(complimentText: content, groupID: Int16(groupOrder))
        dismiss.callAsFunction()
        isCompliment = true
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
                    Button(action:{
                        presentSheet = true
                    }, label:{
                        HStack {
                            Image(systemName: "info.bubble.fill")
                            Text("칭찬요정 tip")
                        }
                    })
                    .accentColor(.black)
                    .sheet(isPresented: $presentSheet) {
                        GeometryReader { geometry in
                            ZStack {
                                Image("tipSheet")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: geometry.size.width, height: geometry.size.height)

                                VStack {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(0..<categories.count, id: \.self) { idx in
                                                TipButton(idx: idx, selection: $selection, categories: categories)
                                            }
                                        }
                                        .padding(.horizontal, 17.0)

                                    }

                                    Text(categories[selection].example)
                                        .font(.system(size: 20, weight: .regular))
                                        .lineSpacing(4)
                                        .foregroundColor(Color(.systemBrown))
                                        .multilineTextAlignment(.center)
                                        .padding()
                                        .padding(.top, 10)

                                    Spacer()

                                    HStack {
                                        Image(systemName: "info.circle")
                                        Text("칭찬은 언제나 가까이 있어요")
                                    }
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor (Color.primary.opacity (0.30))
                                    .padding(.bottom, 20)
                                }
                            }
                            .presentationDetents([.fraction(0.45)])
                            .presentationDragIndicator(.visible)
                        }
                        .padding(.top, 30)
                    }
                    Spacer()
                }
                .padding()
            }
            
            //            VStack(spacing: 0) {
            //                Divider()
            //                    .padding(.top, 5)
            //                Rectangle()
            //                    .fill(Color(.systemGray3))
            //                    .frame(height: 5)
            //                    .opacity(0.15)
            //                Divider()
            //            }
            
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
}

struct TipButton : View {
    var idx: Int
    @Binding var selection: Int
    var categories: [Category]
    
    var body: some View {
        Button(action: {
            selection = idx
        }) {
            Text(categories[idx].title)
                .bold()
                .frame(height: 44)
                .padding(.horizontal)
                .background(idx == selection ? .black : Color(.systemGray6))
                .cornerRadius(10)
                .foregroundColor(idx == selection ? .white : .black)
        }
    }
}


struct WriteComplimentView_Previews: PreviewProvider {
    static var previews: some View {
        WriteComplimentView(isCompliment: .constant(true))
    }
}
