//
//  ArchivingDetailView.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/05/09.
//

import SwiftUI

struct ArchivingDetailView: View {
    
    @StateObject var viewModel: ArchivingDetailViewModel
	@AppStorage("group") var groupOrder: Int = 1
    
	var body: some View {
		VStack {
            if let compliment = viewModel.compliment {
                ArchivingCard(compliment: compliment)
                    .padding(Metric.ArchivingCardPaddingInsets)
                    .onAppear { viewModel.loadCompliment() }
            }
			
			HStack {
                TowardsButton(viewModel: viewModel, direction: .forward)
                
				Spacer()
				
				Text("\(1)번째 상자ㅣ\(1)번째 칭찬")
					.font(.subheadline.bold())
					.foregroundColor(.black.opacity(0.3))
					.padding()
					.overlay(
						RoundedRectangle(cornerRadius: 15)
							.fill(Color("oll").opacity(0.1))
					)

				Spacer()
				
                TowardsButton(viewModel: viewModel, direction: .backward)
			}
		}
		.padding()
		.padding(.top)
		.background(Color.ddoPrimary)
	}
}

struct TowardsButton: View {
    var viewModel: ArchivingDetailViewModel
    let direction: ButtonDirection

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
                .background(viewModel.isButtonDisabled(direction: direction) ? Color("oll").opacity(0.1) : .black.opacity(0.7))
				.cornerRadius(15)
		}
        .disabled(viewModel.isButtonDisabled(direction: direction))
	}
}

struct ArchivingDetailView_Previews: PreviewProvider {
	static var previews: some View {
        ArchivingDetailView(viewModel: ArchivingDetailViewModel(complimentOrder: 1))
			.previewDevice("iPhone SE (3rd generation)")
	}
}

