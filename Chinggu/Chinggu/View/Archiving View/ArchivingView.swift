//
//  ArchivingViewTest.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingView: View {
    @StateObject var viewModel = ArchivingViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            if viewModel.groupOrder >= 2 {
                headerView
                listView
            }
            else {
                emptyView
            }
        }
        .accentColor(.red)
        .padding(.top)
        .background(Color.ddoPrimary)
        .navigationBarBackButtonHidden()
        .toolbar {
            leftItem
        }
    }

    private var headerView: some View {
        Text("\(viewModel.groupOrder - 1)번의 상자를 열었고\n\(viewModel.compliments.count)번 칭찬했어요")
            .font(.title3)
            .fontWeight(.bold)
            .padding(.leading)
    }

    private var listView: some View {
        List {
            ForEach((1..<viewModel.groupOrder).reversed(), id: \.self) { index in
                Section(header: Text("\(index)번째 상자")) {
                    ForEach(viewModel.compliments , id: \.self.id) { compliment in
                        if compliment.groupID == index {
                            ListItemView(compliment: compliment)
                        }
                    }.onDelete(perform: viewModel.deleteCompliment)
                }
            }
        }
        .scrollContentBackground(.hidden)
        .toolbar {
            EditButton()
        }
    }

    private var emptyView: some View {
        ZStack {
            Color.ddoPrimary
            VStack {
                HStack {
                    Text("아직 열어본\n칭찬 상자가 없어요")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.leading)
                    Spacer()
                }
                Spacer()
                Image("emptyArchive")
                Spacer()
            }
        }
    }

    private var leftItem: ToolbarItem<(), some View>{
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.black)
            }
        }
    }
}

private struct ListItemView: View {
    var compliment: ComplimentEntity

    var body: some View {
        NavigationLink(
            destination: ArchivingDetailView(complimentOrder: compliment.order)
                .toolbarRole(.editor),
            label: {
                VStack(alignment: .leading, spacing: 8){
                    if let content = compliment.compliment {
                        Text(content)
                            .font(.headline)
                            .lineLimit(2)
                    }
                    if let date = compliment.createDate {
                        Text(date.formatWithDot())
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                }
            })
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingView()
    }
}
