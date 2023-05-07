//
//  MainView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/06.
//

import SwiftUI
import SpriteKit

enum Weekday: String, CaseIterable {
    case monday = "월요일"
    case tuesday = "화요일"
    case wednesday = "수요일"
    case thursday = "목요일"
    case friday = "금요일"
    case saturday = "토요일"
    case sunday = "일요일"
    
    static var cases: [Weekday] { allCases }
    
    var buttonText: Text {
        Text(rawValue)
    }
}

class GameScene: SKScene {
    let stones = ["sample1", "sample2", "sample3"]
    var currentStoneIndex = 0
    var boxes: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody (edgeLoopFrom: frame)
    }
    
    func addBox(at position: CGPoint) {
        // 이미지가 랜덤으로 나오는 것
        //        let index = Int.random(in: 0..<stones.count)
        let texture = SKTexture(imageNamed: stones[currentStoneIndex])
        let box = SKSpriteNode(texture: texture, size: CGSize(width: 100, height: 100))
        let body = SKPhysicsBody(texture: texture, size: CGSize(width: 100, height: 100))
        box.position = position
        box.physicsBody = body
        addChild(box)
        boxes.append(box)
        
        // 이미지가 순서대로 나올 수 있도록 인덱스를 1씩 추가
        currentStoneIndex += 1
        if currentStoneIndex >= stones.count {
            currentStoneIndex = 0
        }
        
    }
    
    func resetBoxes() {
        // 모든 박스 지우기
        for box in boxes {
            box.removeFromParent()
        }
        boxes.removeAll()
        
        // 인덱스 초기화
        currentStoneIndex = 0
    }
}

struct MainView: View {
    @State private var selectedWeekday: Weekday?
    @State private var showActionSheet = false
    
    let scene = GameScene(size: CGSize(width: 300, height: 400))
    var body: some View {
        VStack {
            SpriteView(scene: scene)
                .frame(width: 300, height: 400)
            
            // 칭찬돌 추가
            Button(action: {
                let position = CGPoint(x: scene.size.width/2,
                                       y: scene.size.height - 50)
                scene.addBox(at: position)
            }, label: {
                Text("Add Box")
            })
            .padding()
            
            // 요일 변경
            Button(action: {
                self.showActionSheet = true
            }, label: {
                Text(selectedWeekday?.rawValue ?? "Change Weekday")
            })
            .padding()
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.cases.map { weekday in
                    if selectedWeekday == weekday {
                        return nil
                    } else {
                        return .default(weekday.buttonText) {
                            self.selectedWeekday = weekday
                        }
                    }
                }.compactMap { $0 } + [.cancel()])
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
