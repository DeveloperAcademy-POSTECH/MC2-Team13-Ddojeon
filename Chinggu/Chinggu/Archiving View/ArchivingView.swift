//
//  ArchivingViewTest.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingView: View {
    @State var isExpanded = false
    
    @State private var chingOrder = [
        "2023. 05. 03 - 2023. 05. 08",
        "2023. 04. 28 - 2023. 05. 02",
        "2023. 05. 03 - 2023. 05. 08",
        "2023. 05. 03 - 2023. 05. 08",
        "2023. 05. 03 - 2023. 05. 08",
        "2023. 05. 03 - 2023. 05. 08"
    ]
    
    @State private var chingText = [
        "1번칭찬",
        "2번칭찬",
        "3번칭찬",
        "4번칭찬"
    ]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("\(chingOrder.count)번의 저금통을 깨고,\n\(chingText.count)번 칭찬했어요.")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading)
                
                List {
                    Section(header: Text("\(chingOrder.count)번째 저금통"), footer: Text(chingOrder[0])
                    ){
                        ForEach(chingText, id: \.self) { item in
                            NavigationLink(destination: ArchivingDetailView().toolbarRole(.editor), label: {
                                VStack(alignment: .leading, spacing: 8){
                                    Text(item)
                                        .font(.headline)
                                        .lineLimit(2)
                                    Text(item)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .lineLimit(1)
                                }
                            })
                        }
                    }
                }
                .scrollContentBackground(.hidden)
//                .listStyle(InsetGroupedListStyle())
//                .navigationTitle("칭찬 보관함")
                .toolbar {
                    EditButton()
                }
            }
            .accentColor(.red)
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
            .background(Color(hex: 0xF9F9F3))
        }
    }
}

struct ArchivingView_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingView()
    }
}
