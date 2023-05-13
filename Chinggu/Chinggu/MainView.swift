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
    var a = 2
    var complimentCount = 0
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        // 칭찬 수 만큼 생성
        for _ in 0..<complimentCount{
            let index = Int.random(in: 1..<99)
            let texture = SKTexture(imageNamed: "stonery\(index)")
            let box = SKSpriteNode(texture: texture)
            let body = SKPhysicsBody(texture: texture, size: texture.size())
            box.position = CGPoint(x: size.width/2, y: size.height - 50)
            box.physicsBody = body
            addChild(box)
            boxes.append(box)
        }
        print(complimentCount)
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
        //        removeAllChildren()
        boxes.removeAll()
    }
}

struct MainView: View {
    @FetchRequest(
        entity: ComplimentEntity.entity(),
        sortDescriptors: []
    ) var Compliment: FetchedResults<ComplimentEntity>
    
    @State private var selectedWeekday: Weekday?
    @State private var showActionSheet = false
    @State private var canBreakBoxes = false
    @State private var showAlert = false
    @State private var showBreakAlert = false
    @State private var tempSeletedWeekday: Weekday?
    @State private var shake = 0.0
    @State private var showPopup = false
    @State private var isCompliment = false
//    @AppStorage("isCompliment") var isCompliment: Bool = false
    
    @State var scene = GameScene()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - geometry.safeAreaInsets.leading - geometry.safeAreaInsets.trailing - 40
            let height = width * 424 / 350

            NavigationView {
                ZStack {
                    Color.ddoPrimary.ignoresSafeArea()
                    VStack {
                        //MARK: 요일 변경하는 버튼
                        HStack {
                            Text("매주")
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 17))
                                .foregroundColor(Color.ddoGray)
                            Button(action: {
                                self.showActionSheet = true
                            }, label: {
                                Text(selectedWeekday?.rawValue ?? "뭔요일")
                                    .font(.custom("AppleSDGothicNeo-Bold", size: 17))
                                    .foregroundColor(.blue)
                                    .padding(.trailing, -8.0)
                                Image(systemName: "arrowtriangle.down.square.fill")
                                    .foregroundColor(.blue)
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
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 17))
                                .foregroundColor(Color.ddoGray)
                            Spacer()
                            
                            //MARK: 아카이브 페이지 링크
                            NavigationLink(destination: TempMainView()) {
                                Image(systemName: "archivebox")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.black)
                            }
                        }.padding(.horizontal, 20.0)
                            .padding(.bottom, -10.0)
                        VStack(spacing: 0) {
                            Divider()
                                .padding(.top, 5)
                            Rectangle()
                                .fill(Color(.systemGray3))
                                .frame(height: 5)
                                .opacity(0.15)
                            Divider()
                        }
                        Spacer()
                        
                        // 타이틀
                        if canBreakBoxes && scene.boxes.count > 0 {
                            Text("저금통을\n확인 할 시간이에요💞")
                                .multilineTextAlignment(.center)
                                .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                                .foregroundColor(Color("oll"))
                                .lineSpacing(5)
                            
                        } else {
                            Text("오늘은 어떤 칭찬을\n해볼까요?✍️")
                                .multilineTextAlignment(.center)
                                .font(.custom("AppleSDGothicNeo-Bold", size: 28))
                                .foregroundColor(Color("oll"))
                                .lineSpacing(5)
                        }
                        Spacer()
                        //MARK: 칭찬 저금통
                        SpriteView(scene: scene)
                            .frame(width: width, height: height)
                            .cornerRadius(26)
                            .onTapGesture {
                                if scene.boxes.count > 0 {
                                    showBreakAlert = true
                                    
                                }
                            }
                        // 중도/만기일 개봉 얼럿
                            .alert(isPresented: $showBreakAlert) {
                                Alert(title: Text(canBreakBoxes ? "개봉 하시겠어요?" : "중도 개봉을 하시겠어요?"), primaryButton: .default(Text("예")) {
                                    // 저금통 초기화
                                    showPopup = true
                                    scene.resetBoxes()
                                }, secondaryButton:.cancel(Text("아니오")))
                            }
                        // 애니메이션
                            .modifier(ShakeEffect(delta: shake))
                            .onChange(of: shake) { newValue in
                                withAnimation(.easeOut(duration: 1.0)) {
                                    if shake == 0 {
                                        shake = newValue
                                    } else {
                                        shake = 0
                                    }
                                }
                                
                            }
                            .onChange(of: Compliment.count) { newValue in
                                scene.addBox(at: CGPoint(x: scene.size.width/2, y: scene.size.height - 50))
                                
                            }
                            .onAppear() {
                                scene.size = CGSize(width: width, height: height)
                                scene.complimentCount = Compliment.count
                                print("appear",Compliment.count)
                                updateCanBreakBoxes()
                                resetTimeButton()
                                scene.scaleMode = .aspectFit
                                if canBreakBoxes && scene.boxes.count > 0 {
                                    shake = 3
                                }
                            }
                        if canBreakBoxes && scene.boxes.count > 0 {
                            Text("저금통을 탭해서 깨보세요!")
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
                                .foregroundColor(Color.ddoGray)
                                .padding(.top, 15)
                        } else {
                            Text("긍정의 힘은 복리로 돌아와요. 커밍쑨!")
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
                                .foregroundColor(Color.ddoGray)
                                .padding(.top, 15)
                        }
                        Spacer()
                        // 칭찬돌 추가하는 버튼
                        Button(action: {
//                            isCompliment = true
//                            scene.addBox(at: CGPoint(x: scene.size.width/2, y: scene.size.height - 50))
                        }, label: {
                            NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment), label: {
                                Text("칭찬하기")
                                    .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                                    .foregroundColor(Color.white)
                                    .kerning(1)
                                    .padding(.vertical,6)
                                    .frame(width: geometry.size.width/1.15, height: 50)
                            })
                        })
//                        .frame(width: geometry.size.width/1.15, height: 50)
//                        .buttonStyle(BorderedButtonStyle())
//                        .background(Color.ddoBlue)
//                    .cornerRadius(10)
                        
//                        NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment), label: {
//                            Text("칭찬하기")
//                                .foregroundColor(.white)
//                                .padding(18.0)
//                        })
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(isCompliment ? .gray : .blue)
                        }
                        .disabled(isCompliment)
                        .padding()
                    }
                }
                .blur(radius: showPopup ? 3 : 0)
                .disabled(showPopup)
                .popup(isPresented: $showPopup) {
                    CardView(showPopup: $showPopup)
                }
            }
        }
    }
    // 요일이 변경 될 때마다 현재 요일과 비교
    func updateCanBreakBoxes() {
        let today = Calendar.current.component(.weekday, from: Date())
        let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
        if todayWeekday == selectedWeekday?.rawValue ?? "선택된 요일이 없음" {
            self.canBreakBoxes = true
            if scene.boxes.count > 0 {
                shake = 3
            }
        } else {
            self.canBreakBoxes = false
        }
    }
    
    // 오전 6시 기준 버튼 초기화
    func resetTimeButton() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let currentTime = formatter.string(from: Date())
        if currentTime == "06:00" {
            isCompliment = false
        }
    }
}

struct ShakeEffect: AnimatableModifier {
    var delta: CGFloat = 0
    
    var animatableData: CGFloat {
        get {
            delta
        } set {
            delta = newValue
        }
    }
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: sin(delta * .pi * 4.0) * CGFloat.random(in: 0.5...1.5)))
            .offset(x: sin(delta * 1.5 * .pi * 1.2),
                    y: cos(delta * 1.5 * .pi * 1.1))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
