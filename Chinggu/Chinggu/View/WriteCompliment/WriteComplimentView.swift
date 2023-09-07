//
//  WriteComplimentView.swift
//  Chinggu
//
//  Created by chaekie on 2023/05/08.
//

import SwiftUI

struct WriteComplimentView: View {
    @ObservedObject var viewModel: WriteComplimentViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var isTipSheetPresented = false
    @FocusState private var isFocused: Bool

    private let cancelAlert: Alerts = .cancelWriting
    private let saveAlert: Alerts = .saveWriting
    @State private var isCancelAlert = false
    @State private var isSaveAlert = false

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

    private var writingView: some View {
        ZStack(alignment: .topLeading) {
            let placeholder = "오늘의 칭찬을 자유롭게 작성해보세요"
            if viewModel.writingContent.isEmpty {
                Text(placeholder)
                    .foregroundColor(Color.primary.opacity (0.30))
                    .padding(.top, 10)
                    .padding(.leading, 5)
            }
            TextEditor(text: $viewModel.writingContent)
                .lineSpacing(5)
                .disableAutocorrection(true)
                .frame(minWidth: 0, maxWidth: .infinity)
                .focused($isFocused)
                .scrollContentBackground(.hidden)
        }
    }

    private var tipView: some View {
        HStack {
            Spacer()
            Button(action:{
                isTipSheetPresented = true
            }, label:{
                HStack {
                    Image(systemName: "info.bubble.fill")
                    Text("작성 tip")
                }
            })
            .accentColor(.black)
            .sheet(isPresented: $isTipSheetPresented) {
                TipSheetView(categories: viewModel.categories)
            }
        }
    }

    private var leftItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                guard !viewModel.writingContent.isEmpty else {
                    return dismiss()
                }
                isCancelAlert = true
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.black)
            }
            .alert(cancelAlert.title,
                   isPresented: $isCancelAlert,
                   presenting: cancelAlert) {cancelAlert in
                Button("나가기", role: .destructive) { dismiss.callAsFunction() }
                Button("취소", role: .cancel) {}
            } message: {article in
                Text(cancelAlert.description)
            }
        }
    }

    private var rightItem: ToolbarItem<(), some View> {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("저장") {
                isSaveAlert = true
            }
            .disabled(viewModel.writingContent.isEmpty ? true : false)
            .alert(saveAlert.title,
                   isPresented: $isSaveAlert,
                   presenting: saveAlert) {saveAlert in
                Button("저장", action: {
                    viewModel.saveCompliment()
                    dismiss.callAsFunction()
                })
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
        WriteComplimentView(viewModel: viewModel)
    }
}
