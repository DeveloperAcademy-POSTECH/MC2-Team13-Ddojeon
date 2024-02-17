//
//  InfoCardView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/15.
//

import SwiftUI

struct InfoPopupView: View {
    @Binding var showInfoPopup: Bool
    @StateObject var viewModel = InfoPopupViewModel()
    
    var body: some View {
        ZStack {
            buildLottieBackground
            
            Image("popup")
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 1, y: 6)
                .overlay {
                    VStack {
                        buildCardTexts
                        buildWeekdaySheetButton
                    }
                }
        }
    }
    
    private var buildLottieBackground: some View {
        LottieView(filename: "cardBeforeAnimation", loopState: false, contentMode: .scaleAspectFill)
            .ignoresSafeArea()
            .transaction { transaction in
                transaction.animation = nil
            }
            .opacity(showInfoPopup ? 1 : 0)
    }
    
    private var buildCardTexts: some View {
        VStack {
            Text("축하해요\n첫 칭찬을 완료했어요")
                .font(.title)
                .bold()
                .multilineTextAlignment(.center)
                .lineSpacing(5)
                .padding(.bottom, 12)
            
            Text("하루 단 한 번, 나를 위해 기록해보세요.\n저장된 칭찬은 내가 설정한 요일에\n해제할 수 있어요. (주 1회)")
                .font(.body)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .foregroundColor(Color.black.opacity(0.6))
        }
    }
    
    private var buildWeekdaySheetButton: some View {
        Button(action: {
            viewModel.toggleShowWeekdaySheet()
        }) {
            Text("요일 설정")
                .font(.title3)
                .bold()
                .foregroundColor(.white)
                .kerning(1)
                .padding(.vertical,6)
                .frame(width: 310, height: 56)
        }
        .actionSheet(isPresented: $viewModel.showWeekdaySheet) {
            ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.allCases.map { weekday in
                return .default(Text(weekday.rawValue)) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        viewModel.updateSelectedWeekday(weekday.rawValue)
                        showInfoPopup = false
                        viewModel.firstComplimentDone()
                    }
                }
            }.compactMap { $0 } + [.cancel()])
        }
        .offset(y: 40)
        .background {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.black)
                .offset(y: 40)
        }
    }
}

struct InfoPopupView_Previews: PreviewProvider {
	static var previews: some View {
		InfoPopupView(showInfoPopup: .constant(true))
	}
}
