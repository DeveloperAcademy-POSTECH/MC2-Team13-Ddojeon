//
//  ArchivingViewTest.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingView: View {
    @StateObject private var viewModel = ArchivingViewModel(groupID: 1)
    @Environment(\.dismiss) private var dismiss
    @AppStorage("group") var groupOrder: Int = 1
//    @FetchRequest(
//        entity: ComplimentEntity.entity(),
//        sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
//    ) var Compliment: FetchedResults<ComplimentEntity>
    
    
    var body: some View {
		NavigationStack{
			VStack(alignment: .leading){
				if groupOrder >= 2 {
                    Text("\(groupOrder - 1)번의 상자를 열었고\n\(viewModel.compliments.count)번 칭찬했어요")
						.font(.title3)
						.fontWeight(.bold)
						.padding(.leading)
					List {
						ForEach((1..<$groupOrder.wrappedValue).reversed(), id: \.self) { index in
							Section(header: Text("\(index)번째 상자")) {
                                ForEach(viewModel.compliments, id: \.self.id) { compliments in
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
									} else { }
								}.onDelete(perform: delete)
							}
						}
					}
					.scrollContentBackground(.hidden)
					.toolbar {
						EditButton()
					}
				}
				else {
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
			.accentColor(.red)
			.padding(.top)
			.background(Color.ddoPrimary)
		}
	}
    
    private func delete(index: IndexSet) {
        viewModel.deleteCompliments(at: index)
    }
}

struct MyPreviewProvider_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingView()
    }
}
