//
//  WriteComplimentView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/08.
//

import SwiftUI

struct WriteComplimentView: View {
    @ObservedObject var viewModel: WriteComplimentViewModel
    @Binding var isCompliment: Bool

    @State private var content = ""

    @Environment(\.dismiss) private var dismiss

    @State private var presentSheet = false
    @FocusState private var isFocused: Bool
    @State private var showingCancelAlert = false
    @State private var showingSaveAlert = false

    @AppStorage("group") var groupOrder: Int = 1

//    private var cancelWriting: Alerts = .cancelWriting
//    private var saveWriting: Alerts = .saveWriting
//    private var cancelAlert: AlertContent
//    private var saveAlert: AlertContent
//
//    init() {
//        cancelAlert = AlertContent(title: cancelWriting.title, description: cancelWriting.description)
//        saveAlert = AlertContent(title: saveWriting.title, description: saveWriting.description)
//    }

    @State private var cancelAlert = AlertContent(title: "정말로 나갈까요?", description: "작성 중인 내용은 저장되지 않아요")
    @State private var saveAlert = AlertContent(title: "칭찬을 저장할까요?", description: "칭찬은 하루에 한 번만 쓸 수 있어요")

    func saveContent () {
        PersistenceController.shared.addCompliment(complimentText: content, groupID: Int16(groupOrder))
        dismiss.callAsFunction()
        isCompliment = true
    }

    func showSaveAlert () {
        showingSaveAlert = true
    }

    var body: some View {
        VStack {
            writingView
            Spacer()
            tipView
        }
        .padding()
        .background(Color.ddoPrimary)
        .onTapGesture {
            isFocused.toggle()
        }
        .navigationTitle("칭찬쓰기")
        .navigationBarBackButtonHidden()
        .toolbar {
            leftItem
            rightItem
        }
    }

    var writingView: some View {
        ZStack(alignment: .topLeading) {
            let placeholder = "오늘의 칭찬을 자유롭게 작성해보세요"
            if content.isEmpty {
                Text(placeholder)
                    .foregroundColor (Color.primary.opacity (0.30))
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
            TextEditor(text: $content)
                .lineSpacing(5)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)
                .focused($isFocused)
                .scrollContentBackground(.hidden)
        }
    }

    var tipView: some View {
        HStack {
            Spacer()
            Button(action:{
                presentSheet = true
            }, label:{
                HStack {
                    Image(systemName: "info.bubble.fill")
                    Text("작성 tip")
                }
            })
            .accentColor(.black)
            .sheet(isPresented: $presentSheet) {
                TipSheetView(categories: viewModel.categories)
            }
        }
    }

    var leftItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(action: {
                guard !content.isEmpty else {
                    return dismiss()
                }
                showingCancelAlert = true
            })
            {
                HStack {
                    Image(systemName: "chevron.backward")
                }
                .foregroundColor(Color.black)
            }
            .alert(cancelAlert.title, isPresented: $showingCancelAlert, presenting: cancelAlert) {saveAlert in
                Button("나가기", role: .destructive) { dismiss.callAsFunction() }
                Button("취소", role: .cancel) {}
            } message: {article in
                Text(cancelAlert.description)
            }
        }
    }

    var rightItem: ToolbarItem<(), some View> {
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




struct WriteComplimentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WriteComplimentViewModel()
        WriteComplimentView(
            viewModel: viewModel,
            isCompliment: .constant(true)
        )
    }
}
