//
//  MainView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/06.
//

import SwiftUI
import SpriteKit
import CoreMotion


// MARK: 메인 뷰
struct MainView: View {
    @FetchRequest(
        entity: ComplimentEntity.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \ComplimentEntity.order, ascending: false)]
    ) var Compliment: FetchedResults<ComplimentEntity>

    
    @State var complimentsInGroup: [ComplimentEntity] = []
    
    @State private var showActionSheet = false
    //    @State private var canBreakBoxes = false
    @State private var showAlert = false
    @State private var showBreakAlert = false
    @State private var tempSeletedWeekday: Weekday?
    @State private var shake = 0.0
    @State private var showPopup = false
    //    @State private var isCompliment = false
    @State private var showInfoPopup = false
    
    @AppStorage("group") var groupOrder: Int = 1
    @AppStorage("isfirst") var isfirst: Bool = true
    @AppStorage("selectedWeekday") private var selectedWeekday: String = Weekday.today.rawValue
    
    //    @AppStorage("isSelectedSameDay") private var isSelectedSameDay: Bool = true
    @AppStorage("isCompliment") private var isCompliment: Bool = false
    @AppStorage("canBreakBoxes") private var canBreakBoxes = false
    @State var scene = GameScene()
    
    @AppStorage("lastResetTimeInterval") private var lastResetTimeInterval: TimeInterval = Date().timeIntervalSinceNow
    @AppStorage("selectedWeekdayTimeInterval") private var selectedWeekdayTimeInterval: TimeInterval = Date().addingTimeInterval(TimeInterval(7 * 24 * 60 * 60)).timeIntervalSince1970
    
    //    var lastResetDate: Date {
    //        let lastResetTime = Date(timeIntervalSince1970: lastResetTimeInterval)
    //        return lastResetTime
    //    }
    
    @Environment(\.scenePhase) var scenePhase
    
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
                                .bold()
                                .font(.body)
                                .foregroundColor(.gray)
                            Button(action: {
                                self.showActionSheet = true
                            }, label: {
                                Text(selectedWeekday)
                                    .bold()
                                    .font(.body)
                                    .foregroundColor(!self.isfirst ? .blue : .gray)
                                    .padding(.trailing, -8.0)
                                Image(systemName: "arrowtriangle.down.square.fill")
                                    .foregroundColor(!self.isfirst ? .blue : .gray)
                            })
                            .disabled(self.isfirst)
                            .padding(.horizontal)
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
                                    selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
                                    updateCanBreakBoxes()
                                }, secondaryButton: .cancel(Text("아니요")))
                            }.padding(.horizontal, -19.0)
                            Text("에 칭찬 상자가 열려요")
                                .bold()
                                .font(.body)
                                .foregroundColor(.gray)
                            
                            Spacer()

                            //MARK: 아카이브 페이지 링크
                            NavigationLink(destination: ArchivingView()) {
                                Image(systemName: "archivebox")
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                    .foregroundColor(.black)
                            }

                        }

                        .padding(.horizontal, 20.0)
                        .padding(.vertical, 10.0)
                        VStack(spacing: 0) {
                            Divider()
                            Rectangle()
                                .fill(Color(.systemGray3))
                                .frame(height: 5)
                                .opacity(0.15)
                            Divider()
                        }
                        .padding(.bottom, 30)

                        //                        // MARK: 테스트 버튼
                        //                        Button("초기화") {
                        //                            isCompliment = false
                        //                        }
                        //                        Text("Next \(selectedWeekday) Date: \(Date(timeIntervalSince1970: selectedWeekdayTimeInterval))")
                        //                        Text("\(Date())")
                        //                        Text("\(Date(timeIntervalSince1970: lastResetTimeInterval))")
                        //                        Text(Date() > Date(timeIntervalSince1970: selectedWeekdayTimeInterval) ? "true" : "false")

                        // 타이틀
                        if canBreakBoxes && scene.boxes.count > 0  {
                            Text("이번 주 칭찬을\n  확인할 시간이에요💞")
                                .tracking(-0.3)
                                .multilineTextAlignment(.center)
                                .bold()
                                .font(.title)
                                .foregroundColor(Color("oll"))
                                .lineSpacing(5)
                                .padding(.bottom, 25)

                        } else {
                            Text("오늘은 어떤 칭찬을\n해볼까요?✍️")
                                .tracking(-0.3)
                                .multilineTextAlignment(.center)
                                .bold()
                                .font(.title)
                                .foregroundColor(Color("oll"))
                                .lineSpacing(5)
                                .padding(.bottom, 25)
                        }

                        //MARK: 칭찬 저금통
                        SpriteView(scene: scene)
                            .frame(width: width, height: height)
                            .cornerRadius(26)
                            .onTapGesture {
                                if scene.boxes.count > 0 && canBreakBoxes {
                                    showBreakAlert = true
                                }
                            }
                            .overlay {
                                if complimentsInGroup.count == 0 && !isCompliment {
                                    NavigationLink(destination: WriteComplimentView()) {
                                        Image("emptyState")
                                    }
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
                                        selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
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
                                print(complimentsInGroup.count)
                                if complimentsInGroup.count > scene.complimentCount {
                                    scene.addBox(at: CGPoint(x: scene.size.width/2, y: scene.size.height - 50))
                                    if canBreakBoxes {
                                        shake = 4
                                    }
                                }

                                scene.size = CGSize(width: width, height: height)
                                scene.complimentCount = complimentsInGroup.count
                                // 일주일 지나도 0개 일때, 일주일 더 추가
                                if Date(timeIntervalSince1970: selectedWeekdayTimeInterval) <= Date() && complimentsInGroup.isEmpty {
                                    selectedWeekdayTimeInterval = nextWeekdayDate(selectedWeekday)
                                }
                                compareDates()
                                updateCanBreakBoxes()
                                
                                scene.scaleMode = .aspectFit
                            }
                        if complimentsInGroup.count == 7 {
                            Text("주간 칭찬은 최대 7개 까지만 가능해요.")
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
                                .foregroundColor(.gray)
                                .padding(.top, 14)
                        } else if canBreakBoxes && scene.boxes.count > 0  {
                            Text("칭찬 상자를 톡! 눌러주세요.")
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
                                .foregroundColor(.gray)
                                .padding(.top, 14)
                        } else {
                            Text("긍정의 힘은 복리로 돌아와요. 커밍쑨!")
                                .font(.custom("AppleSDGothicNeo-SemiBold", size: 14))
                                .foregroundColor(.gray)
                                .padding(.top, 14)
                        }
                        Spacer()
                        // 칭찬돌 추가하는 버튼
                        Button(action: {
                        }, label: {
                            NavigationLink(destination: WriteComplimentView(), label: {
                                Text(isCompliment ? "오늘 칭찬 끝!" : "칭찬하기")
                                    .bold()
                                    .font(.title3)
                                    .foregroundColor(Color.white)
                                    .kerning(0.5)
                                    .padding(.vertical,6)
                                    .frame(width: width, height: 56)
                            })
                        })
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(isCompliment || complimentsInGroup.count == 7 ? Color(red: 0.85, green: 0.85, blue: 0.85) : .blue)
                        }
                        .disabled(isCompliment)
                        .disabled(complimentsInGroup.count == 7)
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
                .onChange(of: groupOrder, perform: { newValue in
                    complimentsInGroup = CoreDataManager.shared.fetchComplimentsInGroup(Int16(newValue))
                })
                .onChange(of: scenePhase) { newPhase in
                    print("scene change")
                    compareDates()
                    updateCanBreakBoxes()
                }
                .onAppear {
                    complimentsInGroup = CoreDataManager.shared.fetchComplimentsInGroup(Int16(groupOrder))
                    // 최초 칭찬 작성 시 안내 팝업
                    if Compliment.count == 1, isfirst == true {
//                        withAnimation(.spring(response: 1.2, dampingFraction: 0.8)) {
                            showInfoPopup = true
//                        }
                    }
                }
                
            }
        }
    }
    //// 요일이 변경 될 때마다 현재 요일과 비교
    // 현재 날짜와 nextWeekdayDate와 비교
    private func updateCanBreakBoxes() {
        let today = Date().timeIntervalSince1970
        //        let boxDay = selectedWeekdayDate
        //        let today = Calendar.current.component(.weekday, from: Date())
        //        let todayWeekday = Weekday.allCases[(today + 5) % 7].rawValue
        //        if isPastSelectedWeekday() && !isSelectedSameDay {
        if today >= selectedWeekdayTimeInterval {
            //        if (todayWeekday == selectedWeekday) && !isSelectedSameDay {
            canBreakBoxes = true
            if scene.complimentCount > 0 {
                shake = 5
            }
        } else {
            canBreakBoxes = false
        }
    }
    // 선택한 요일에 해당하는 다음 날짜 추출
    func nextWeekdayDate(_ weekdayString: String) -> TimeInterval {
        let calendar = Calendar.current
        let weekdays = Weekday.allCases
        
        let selectedWeekday = weekdays.first(where: { $0.rawValue == weekdayString }) ?? .monday
        let today = calendar.startOfDay(for: Date())
        var nextDate = today
        //        var components = DateComponents()
        
        for dayOffset in 1...7 {
            nextDate = today.addingTimeInterval(TimeInterval(dayOffset * 24 * 60 * 60))
            if calendar.component(.weekday, from: nextDate) == selectedWeekday.weekdayValue {
                break
            }
        }
        return nextDate.timeIntervalSince1970
    }
    
    
    // 초기화 날짜 비교 및 버튼 초기화
    private func compareDates() {
        let calendar = Calendar.current
        let lastResetDate = Date(timeIntervalSince1970: lastResetTimeInterval)
        if !calendar.isDateInToday(lastResetDate) {
            //            resetTimeButton()
            isCompliment = false
            lastResetTimeInterval = Date().timeIntervalSince1970
        }
    }
}

struct ShakeEffect: AnimatableModifier {
    var delta: CGFloat = 0

    var animatableData: CGFloat {
        get { delta }
        set { delta = newValue }
    }

    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: sin(delta * .pi * 4.0) * CGFloat.random(in: 0.5...1.5)))
            .offset(x: sin(delta * 1.5 * .pi * 1.2),
                    y: cos(delta * 1.5 * .pi * 1.1))
    }
}

//class HapticManager {
//    static let instance = HapticManager()
//
//    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(type)
//    }
//
//    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
//        let generator = UIImpactFeedbackGenerator(style: style)
//        generator.impactOccurred()
//    }
//}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
