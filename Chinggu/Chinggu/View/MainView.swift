//
//  MainView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/06.
//요일변경되니까 사라짐 /

import SwiftUI
import SpriteKit
import CoreMotion

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
    var complimentCount = 0
	let motionManager = CMMotionManager()
    
    override func didMove(to view: SKView) {
		physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
		
		motionManager.deviceMotionUpdateInterval = 0.1
		motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
			guard let motion = motion else { return }
			let x = motion.gravity.x
			let y = motion.gravity.y
			self.physicsWorld.gravity = CGVector(dx: x * 35, dy: y * 35)
		}
		for i in 0..<complimentCount {
			DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * Double(i)) {
				self.addBox(at: CGPoint(x: UIScreen.main.bounds.width / 2,
										y: UIScreen.main.bounds.height / 2.5))
			}
		}
		print("sk",complimentCount)
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
        sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
    ) var Compliment: FetchedResults<ComplimentEntity>
    
	@State var complimentsInGroup: [ComplimentEntity] = []
    
	@AppStorage("selectedWeekday") private var selectedWeekday: String = Weekday.monday.rawValue

//    @State private var selectedWeekday: Weekday?
    @State private var showActionSheet = false
    @State private var canBreakBoxes = false
    @State private var showAlert = false
    @State private var showBreakAlert = false
    @State private var tempSeletedWeekday: Weekday?
    @State private var shake = 0.0
    @State private var showPopup = false
    @State private var isCompliment = false
    @State private var showInfoPopup = false
//    @State private var firstInfoPopup = true
	
//	@AppStorage("isCompliment") var isCompliment: Bool = false
	@AppStorage("group") var groupOrder: Int = 1
	@AppStorage("isfirst") var isfirst: Bool = true


    
    @State var scene = GameScene()
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - geometry.safeAreaInsets.leading - geometry.safeAreaInsets.trailing - 40
            let height = width * 424 / 350

			NavigationStack {
				ZStack {
					Color.ddoPrimary.ignoresSafeArea()
					VStack {
						//MARK: 요일 변경하는 버튼
						HStack {
							Text("매주")
								.font(.custom("AppleSDGothicNeo-SemiBold", size: 17))
								.foregroundColor(.gray)
							Button(action: {
								self.showActionSheet = true
							}, label: {
								Text(selectedWeekday)
									.font(.custom("AppleSDGothicNeo-Bold", size: 17))
									.foregroundColor(.blue)
									.padding(.trailing, -8.0)
								Image(systemName: "arrowtriangle.down.square.fill")
									.foregroundColor(.blue)
							})
							.padding()
							.actionSheet(isPresented: $showActionSheet) {
								ActionSheet(title: Text("요일 변경"), message: nil, buttons: Weekday.allCases.map { weekday in
									if selectedWeekday == weekday.rawValue {
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
								Alert(title: Text("매주 \(tempSeletedWeekday?.rawValue ?? "월요일")"), message: Text("선택한 요일로 변경할까요?"), primaryButton: .default(Text("네")) {
									// OK 버튼을 눌렀을 때 선택한 요일 업데이트
									self.selectedWeekday = self.tempSeletedWeekday?.rawValue ?? "월요일"
									updateCanBreakBoxes()
								}, secondaryButton: .cancel(Text("아니요")))
							}.padding(.horizontal, -19.0)
							Text("에 칭찬 상자가 열려요")
								.font(.custom("AppleSDGothicNeo-SemiBold", size: 17))
								.foregroundColor(.gray)
							Spacer()
							
							//MARK: 아카이브 페이지 링크
							NavigationLink(destination: ArchivingView()) {
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
						.padding(.bottom, 30)

						// 타이틀
						if canBreakBoxes && scene.boxes.count > 0  {
							Text("이번 주 칭찬을\n  확인할 시간이에요💞")
								.multilineTextAlignment(.center)
								.font(.custom("AppleSDGothicNeo-Bold", size: 28))
								.foregroundColor(Color("oll"))
								.lineSpacing(5)
								.padding(.bottom, 25)

						} else {
							Text("오늘은 어떤 칭찬을\n해볼까요?✍️")
								.multilineTextAlignment(.center)
								.font(.custom("AppleSDGothicNeo-Bold", size: 28))
								.foregroundColor(Color("oll"))
								.lineSpacing(5)
								.padding(.bottom, 25)
						}
						Spacer()
						
						//MARK: 칭찬 저금통
						SpriteView(scene: scene)
							.frame(width: width, height: height)
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
								withAnimation(.easeOut(duration: 2.0)) {
									if shake == 0 {
										shake = newValue
									} else {
										shake = 0
									}
								}
								
							}
							.onAppear {
								if complimentsInGroup.count > scene.complimentCount {
									scene.addBox(at: CGPoint(x: scene.size.width/2, y: scene.size.height - 50))
									if canBreakBoxes {
										shake = 5
									}
								}

								scene.size = CGSize(width: width, height: height)
//								print("appear",complimentsInGroup.count)
								scene.complimentCount = complimentsInGroup.count
								updateCanBreakBoxes()
								resetTimeButton()
								scene.scaleMode = .aspectFit
								print("AllCompliment.count : ",Compliment.count)
								print("complimentsInGroup.count : ",complimentsInGroup.count)
								print("scene.complimentCount : ",scene.complimentCount)
							}
//                            .onChange(of: complimentsInGroup.count) { newValue in
//								if complimentsInGroup.count > 0 {
//									scene.addBox(at: CGPoint(x: scene.size.width/2, y: scene.size.height - 50))
//									if canBreakBoxes {
//										shake = 5
//									}
//								}
//                            }
						if canBreakBoxes && scene.boxes.count > 0  {
							Text("칭찬 상자를 톡! 눌러주세요")
								.font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
								.foregroundColor(.gray)
								.padding(.top, 14)
						} else {
							Text("긍정의 힘은 복리로 돌아와요 커밍쑨!")
								.font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
								.foregroundColor(.gray)
								.padding(.top, 14)
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
								.foregroundColor(.blue)
//                                .foregroundColor(isCompliment ? .gray : .blue)
						}
//                        .disabled(isCompliment)
					}
					if scene.complimentCount == 0 {
						NavigationLink(destination: WriteComplimentView(isCompliment: $isCompliment)) {
							Image("emptyState")
								.offset(y: 45)
						}
					}
					Color.clear
					.popup(isPresented: $showPopup) {
						CardView(showPopup: $showPopup)
					}
                    // 최초 칭찬 작성 시 안내 팝업
					.popup(isPresented: $showInfoPopup) {
						InfoPopupView(showInfoPopup: $showInfoPopup)
					}
                }
				.onAppear {
					complimentsInGroup = PersistenceController.shared.fetchComplimentInGroup(groupID: Int16(groupOrder))
                    // 최초 칭찬 작성 시 안내 팝업
					if Compliment.count == 1, isfirst == true {
						withAnimation(.spring(response: 1.2, dampingFraction: 0.8)) {
							showInfoPopup = true
						}
					}
				}
                
            }
        }
    }
    // 요일이 변경 될 때마다 현재 요일과 비교
    private func updateCanBreakBoxes() {
        let today = Calendar.current.component(.weekday, from: Date())
        let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
        if todayWeekday == selectedWeekday {
            self.canBreakBoxes = true
            if scene.complimentCount > 0 {
                shake = 5
            }
        } else {
            self.canBreakBoxes = false
        }
    }
    
    // 오전 6시 기준 버튼 초기화
    private func resetTimeButton() {
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
