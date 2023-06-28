//
//  ArchivingViewTest.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingView: View {
    @FetchRequest(
        entity: ComplimentEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
    ) var Compliment: FetchedResults<ComplimentEntity>
    @AppStorage("group") var groupOrder: Int = 1
    
    @Environment(\.dismiss) private var dismiss
    @State var editMode: EditMode = .inactive
    @State var isEditing = false
    
    var body: some View {
        VStack {
            if groupOrder >= 2 {
                VStack(alignment: .leading) {
                    Text("\(groupOrder - 1)번의 상자를 열었고\n\(Compliment.count)번 칭찬했어요")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding([.leading, .top])
                    List {
                        ForEach((1..<$groupOrder.wrappedValue).reversed(), id: \.self) { index in
                            Section(header: Text("\(index)번째 상자")) {
                                ForEach(Compliment, id: \.self.id) { compliments in
                                    if compliments.groupID == index {
                                        NavigationLink(
                                            destination: ArchivingDetailView(complimentOrder: compliments.order).toolbarRole(.editor), label: {
                                                VStack(alignment: .leading, spacing: 8){
                                                    let currentDate = compliments.createDate
                                                    let strDate = currentDate?.formatWithDot()
                                                    Text(compliments.compliment ?? "")
                                                        .font(.headline)
                                                        .lineLimit(2)
                                                    Text(strDate ?? "")
                                                        .font(.subheadline)
                                                        .foregroundColor(.gray)
                                                        .lineLimit(1)
                                                }
                                            })
                                    }
                                }.onDelete(perform: delete)
                            }
                        }
                    }
                }
            }
            else {
                VStack {
                    HStack {
                        Text("아직 열어본\n칭찬상자가 없어요")
                            .font(.title2)
                            .lineSpacing(9)
                            .bold()
                        Spacer()
                    }
                    Spacer()
                    VStack(spacing: 54) {
                        Image("empty_archive")
                        Text("첫 칭찬 상자를 열면\n기록을 확인할 수 있어요!")
                            .multilineTextAlignment(.center)
                            .font(.headline)
                            .lineSpacing(3)
                            .foregroundColor(Color(.systemGray2))
                            .fontWeight(.regular)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                .padding()
            }
            
        }
        .environment(\.editMode, $editMode)
        .background(Color.ddoPrimary)
        .scrollContentBackground(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.black)
                }
            }
            if groupOrder >= 2 {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isEditing.toggle()
                        editMode = isEditing ? .active : .inactive
                    }) {
                        Text(isEditing ? "완료" : "수정")
                            .foregroundColor(isEditing ? .blue : .black)
                    }
                }
            }
        }
    }
    
    private func delete(indexset: IndexSet) {
        guard let index = indexset.first else { return }
        let selectedEntity = Compliment[index]
        PersistenceController.shared.deleteCompliment(compliment: selectedEntity)
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingView()
    }
}
