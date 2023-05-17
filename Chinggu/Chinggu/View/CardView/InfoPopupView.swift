//
//  InfoCardView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/15.
//

import SwiftUI

struct InfoPopupView: View {
    @Binding var showInfoPopup: Bool
	@AppStorage("isfirst") var isfirst: Bool = false

    var body: some View {
        ZStack {
            LottieView(filename: "cardBeforeAnimation", loopState: false)
                .ignoresSafeArea()
				.transaction { transaction in
					transaction.animation = nil
				}
                .opacity(showInfoPopup ? 1 : 0)
            
            Image("popup")
                .shadow(color: Color.black.opacity(0.2), radius: 7, x: 1, y: 6)
				.overlay {
					VStack {
						Text("축하해요\n첫 칭찬을 완료했어요")
							.font(.custom("AppleSDGothicNeo-Bold", size: 28))
							.multilineTextAlignment(.center)
							.lineSpacing(5)
							.padding(.bottom, 12)
						
						Text("하루 단 한 번, 나를 위해 기록해보세요.\n저장된 칭찬은 내가 설정한 요일에\n해제할 수 있어요. (주 1회)")
							.font(.custom("AppleSDGothicNeo-Medium", size: 17))
							.multilineTextAlignment(.center)
							.foregroundColor(Color.black.opacity(0.7))
							.lineSpacing(3)
						
						Button(action: {
                            print(1)
							withAnimation(.easeOut(duration: 0.5)) {
								showInfoPopup = false
								isfirst = false
							}
						}) {
							Text("확인")
								.font(.custom("AppleSDGothicNeo-Bold", size: 20))
								.foregroundColor(.white)
								.kerning(1)
								.padding(.vertical,6)
                                .frame(width: 310, height: 56)
						}
                        .offset(y: 40)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(.black)
                                .offset(y: 40)
                        }
					}
				}
        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.black.opacity(0.5))
//        .onTapGesture {
//            // 배경 탭하면 팝업 닫기
//            withAnimation {
//                showInfoPopup = false
//            }
//        }
//        .transition(.opacity)
//        .animation(.easeInOut(duration: 0.3))
    }
}

struct InfoPopupView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPopupView(showInfoPopup: .constant(true))
    }
}
