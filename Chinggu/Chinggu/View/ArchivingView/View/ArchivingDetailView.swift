//
//  ArchivingDetailView.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingDetailView: View {
    
    @StateObject var viewModel: ArchivingDetailViewModel
    var compliment: ComplimentEntity
    
    init(compliment: ComplimentEntity) {
        self.compliment = compliment
        _viewModel = StateObject(wrappedValue: ArchivingDetailViewModel(compliment: compliment))
    }
    
    var body: some View {
        VStack {
            if let compliment = viewModel.compliment {
                ArchivingCard(compliment: compliment)
                    .padding(Metric.ArchivingCardPaddingInsets)
                    .onAppear { viewModel.loadCompliment() }
                
                HStack {
                    TowardsButton(viewModel: viewModel, direction: .forward)
                    
                    Spacer()
                    
                    Text("\(compliment.groupID)번째 상자ㅣ\(compliment.order)번째 칭찬")
                        .font(.subheadline.bold())
                        .foregroundColor(.black.opacity(0.3))
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: RectangleStyle.roundedRectangleRadius)
                                .fill(Color("oll").opacity(0.1))
                        )
                    
                    Spacer()
                    
                    TowardsButton(viewModel: viewModel, direction: .backward)
                }
            }
        }
        .padding()
        .padding(.top)
        .background(Color.ddoPrimary)
    }
}

struct TowardsButton: View {
    @ObservedObject var viewModel: ArchivingDetailViewModel
    let direction: TowardsButtonDirection

	var body: some View {
		Button {
            switch direction {
            case .forward:
                viewModel.nextCompliment()
            case .backward:
                viewModel.previousCompliment()
            }
		} label: {
			Image(systemName: direction == .forward ? "arrow.backward" : "arrow.forward")
				.padding()
				.foregroundColor(.white)
                .background {
                    viewModel.isButtonDisabled(direction: direction) ? Color("oll").opacity(0.1) : .black.opacity(0.7)
                }
				.cornerRadius(15)
		}
        .disabled(viewModel.isButtonDisabled(direction: direction))
	}
}
