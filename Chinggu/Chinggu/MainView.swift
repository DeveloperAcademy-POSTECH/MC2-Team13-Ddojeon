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
}

class GameScene: SKScene {
    var boxes: [SKSpriteNode] = []
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        // 배경색 변경
        //        self.backgroundColor = .red
    }
    
    func addBox(at position: CGPoint) {
        // 이미지가 랜덤으로 나오는 것
        let index = Int.random(in: 1..<99)
        let texture = SKTexture(imageNamed: "stonery\(index)")
        let box = SKSpriteNode(texture: texture)
        let body = SKPhysicsBody(texture: texture, size: texture.size())
        box.position = position
        box.physicsBody = body
        addChild(box)
        boxes.append(box)
    }
    
    func resetBoxes() {
        // 모든 박스 지우기
        for box in boxes {
            box.removeFromParent()
        }
        boxes.removeAll()
    }
    
    //    func shake() {
    //            // Scene 좌우로 진동하는 애니메이션 추가
    //            let moveRight = SKAction.moveBy(x: 10, y: 0, duration: 0.05)
    //            let moveLeft = SKAction.moveBy(x: -20, y: 0, duration: 0.1)
    //            let moveCenter = SKAction.moveBy(x: 10, y: 0, duration: 0.05)
    //            let sequence = SKAction.sequence([moveRight, moveLeft, moveCenter])
    //            let repeatShake = SKAction.repeat(sequence, count: 3)
    //            run(repeatShake)
    //        }
}

struct MainView: View {
    @State private var selectedWeekday: Weekday? {
        didSet {
            updateCanBreakBoxes()
        }
    }
    @State private var showActionSheet = false
    @State private var canBreakBoxes = false
    @State private var showAlert = false
    @State private var showBreakAlert = false
    @State private var tempSeletedWeekday: Weekday?
    
    let scene = GameScene(size: CGSize(width: 350, height: 450))
    var body: some View {
        NavigationView {
            ZStack {
                Color.ddoPrimary.ignoresSafeArea()
                VStack {
                    //MARK: 요일 변경하는 버튼
                    HStack {
                        Text("매주")
                            .tracking(-0.5)
                        Button(action: {
                            self.showActionSheet = true
                        }, label: {
                            Text(selectedWeekday?.rawValue ?? "뭔요일")
                                .padding(.trailing, -7.0)
                            Image(systemName: "arrowtriangle.down.square.fill")
                        })
                        .padding()
                        .actionSheet(isPresented: $showActionSheet) {
                            ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.allCases.map { weekday in
                                if selectedWeekday == weekday {
                                    return nil
                                } else {
                                    return .default(Text(weekday.rawValue)) {
                                        self.showAlert = true
                                        self.tempSeletedWeekday = weekday
                                    }
                                }
                            }.compactMap { $0 } + [.cancel()])
                        }
                        // 요일 변경할건지 얼럿
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("매주 \(tempSeletedWeekday?.rawValue ?? "뭔요일")"), message: Text("선택한 요일로 변경하시겠습니까?"), primaryButton: .default(Text("예")) {
                                // OK 버튼을 눌렀을 때 선택한 요일 업데이트
                                self.selectedWeekday = self.tempSeletedWeekday
                                updateCanBreakBoxes()
                            }, secondaryButton: .cancel(Text("아니오")))
                        }.padding(.horizontal, -19.0)
                        Text("은 칭찬 저금통을 깨는 날!")
                            .tracking(-0.5)
                        Spacer()
                        
                        //MARK: 아카이브 페이지 링크
                        NavigationLink(destination: ContentView()) {
                            Image(systemName: "archivebox")
                        }
                    }.padding(.horizontal, 20.0)
                    Spacer()
                    
                    // 타이틀
                    Text("오늘은 어떤 칭찬을 해볼까요?✍️")
                    
                    //MARK: 칭찬 저금통
                    SpriteView(scene: scene)
                        .frame(width: 350, height: 450)
                        .background(.white)
                        .cornerRadius(26)
                    //                    .animation(canBreakBoxes ? shake : nil, value: canBreakBoxes)
                    //                    .id(canBreakBoxes)
                        .onTapGesture {
                            if scene.boxes.count > 0 {
                                showBreakAlert = true
                                    
                            }
                        }
                    // 중도/만기일 개봉 얼럿
                        .alert(isPresented: $showBreakAlert) {
                            Alert(title: Text(canBreakBoxes ? "개봉 하시겠어요?" : "중도 개봉을 하시겠어요?"), primaryButton: .default(Text("예")) {
                                // 저금통 초기화
                                scene.resetBoxes()
                            }, secondaryButton:.cancel(Text("아니오")))
                        }
                    
                    Spacer()
                    // 칭찬돌 추가하는 버튼
                    Button(action: {
                        //                    scene.shake()
                        let position = CGPoint(x: scene.size.width/2,
                                               y: scene.size.height - 50)
                        scene.addBox(at: position)
                    }, label: {
                        Text("칭찬하기")
                    })
                    .padding()
                    
                    // 저금통 깨는 버튼
                    //                Button(action: {
                    //                    scene.resetBoxes()
                    //                    canBreakBoxes = false
                    //                }, label: {
                    //                    Text("Break Box")
                    //                })
                    //                .disabled(!canBreakBoxes)
                }
            }
        }
    }
    
    //    var shake: Animation {
    //        Animation.spring(response: 0.2, dampingFraction: 0.3, blendDuration: 0)
    //            .repeatForever(autoreverses: true)
    //    }
    
    // 요일이 변경 될 때마다 현재 요일과 비교
    func updateCanBreakBoxes() {
        let today = Calendar.current.component(.weekday, from: Date())
        let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
        if todayWeekday == selectedWeekday?.rawValue ?? "선택된 요일이 없음" {
            self.canBreakBoxes = true
        } else {
            self.canBreakBoxes = false
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
