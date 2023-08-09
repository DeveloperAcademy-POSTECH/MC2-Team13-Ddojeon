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
		SpriteView(scene: scene)
			.frame(width: 300, height: 400)
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
				scene.size = CGSize(width: 300, height: 400)
				scene.complimentCount = complimentsInGroup
//				scene.canBreakBoxes = canBreakBoxes
				scene.scaleMode = .aspectFit

				if canBreakBoxes {
					shake = 4
				}
//				updateCanBreakBoxes()
			}
    }
}

struct HomeComplimentBox_Previews: PreviewProvider {
    static var previews: some View {
		HomeComplimentBox(showPopup: .constant(false), complimentsInGroup: .constant(5))
    }
}
