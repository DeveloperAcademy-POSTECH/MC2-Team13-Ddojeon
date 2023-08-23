//
//  HomeComplimentBox.swift
//  Chinggu
//
//  Created by Junyoo on 2023/08/10.
//

import SwiftUI
import SpriteKit

struct HomeComplimentBox: View {
	
	@State private var scene = GameScene()
	@State private var shake = 0.0
	@State private var showBreakAlert = false
	
	@Binding var showPopup: Bool
	@Binding var complimentsInGroup: Int
	
	@AppStorage("canBreakBoxes") private var canBreakBoxes = false
	
    var body: some View {
		VStack {
			SpriteView(scene: scene)
				.frame(width: 350, height: 424)
				.cornerRadius(26)
				.onTapGesture {
					if scene.boxes.count > 0 && canBreakBoxes {
						showBreakAlert = true
					}
				}
			// 만기일 개봉 얼럿
				.alert(isPresented: $showBreakAlert) {
					Alert(title: Text("칭찬 상자를 열어볼까요?"), primaryButton: .default(Text("네")) {
						// 저금통 초기화
						withAnimation(.easeOut(duration: 1)) {
							scene.resetBoxes()
							scene.complimentCount = 0
							showPopup = true
						}
					}, secondaryButton:.cancel(Text("아니요")))
				}
			// 애니메이션
				.modifier(ShakeEffect(delta: shake))
				.onChange(of: shake) { newValue in
					withAnimation(.easeOut(duration: 1.5)) {
						if canBreakBoxes {
							if shake == 0 {
								shake = newValue
							} else {
								shake = 0
							}
						}
					}
				}
				.onAppear {
					scene.size = CGSize(width: 350, height: 424)
					scene.complimentCount = complimentsInGroup
	//				scene.canBreakBoxes = canBreakBoxes
					scene.scaleMode = .aspectFit

					if canBreakBoxes {
						shake = 4
					}
	//				updateCanBreakBoxes()
			}
			
			//MARK: subtitle
			if complimentsInGroup == 7 {
				subTitleView(title: "주간 칭찬은 최대 7개 까지만 가능해요.")
			} else if canBreakBoxes && scene.boxes.count > 0  {
				subTitleView(title: "칭찬 상자를 톡! 눌러주세요.")
			} else {
				subTitleView(title: "긍정의 힘은 복리로 돌아와요. 커밍쑨!")
			}
		}
    }	
}

struct HomeComplimentBox_Previews: PreviewProvider {
    static var previews: some View {
		HomeComplimentBox(showPopup: .constant(false), complimentsInGroup: .constant(5))
    }
}
