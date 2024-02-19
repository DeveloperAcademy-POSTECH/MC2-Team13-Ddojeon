//
//  ArchivingViewTest.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingView: View {
    @StateObject var viewModel = ArchivingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                if viewModel.userRepository.groupOrder > 1 {
                    listView
                } else {
                    NoComplimentsBoxView()
                }
            }
            .accentColor(.red)
            .padding(.top)
            .background(Color.ddoPrimary)
        }
        .onAppear {
            viewModel.fetchCompliments()
        }
    }
    
    private var listView: some View {
        VStack(alignment: .leading) {
            Text("\(viewModel.userRepository.groupOrder - 1)번의 상자를 열었고\n\(viewModel.compliments.count)번 칭찬했어요")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.leading)
            List {
                complimentsSection
            }
            .scrollContentBackground(.hidden)
            .toolbar {
                EditButton()
            }
        }
    }
    
    private var complimentsSection: some View {
        ForEach((1..<viewModel.userRepository.groupOrder).reversed(), id: \.self) { index in
            Section(header: Text("\(index)번째 상자")) {
                ForEach(viewModel.filterComplimentsInGroup(by: index)) { compliment in
                    complimentRow(for: compliment)
                }
                .onDelete(perform: delete)
            }
        }
    }
    
    private func complimentRow(for compliment: ComplimentEntity) -> some View {
        NavigationLink(destination: ArchivingDetailView(compliment: compliment)) {
            VStack(alignment: .leading, spacing: 8) {
                Text(compliment.compliment ?? "")
                    .font(.headline)
                    .lineLimit(2)
                Text(compliment.createDate?.formatWithDot() ?? "")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
        }
    }
    
    private func delete(indexSet: IndexSet) {
        viewModel.deleteCompliments(at: indexSet)
    }
}

struct NoComplimentsBoxView: View {
    var body: some View {
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
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingView()
    }
}
