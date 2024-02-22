//
//  MainView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/06.
//

import SwiftUI
import SpriteKit

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    @Environment(\.scenePhase) var scenePhase
    @State private var showPopup = false
    @State private var showInfoPopup = false
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width - geometry.safeAreaInsets.leading - geometry.safeAreaInsets.trailing - 40
            let height = width * 424 / 350
            
            NavigationStack {
                ZStack {
                    Color.ddoPrimary.ignoresSafeArea()
                    VStack {
                        //요일 변경 버튼
                        buildHeader
                        
                        buildDivider
                        
                        buildTitle
                        
                        //칭찬 저금통
                        buildComplimentBox(width: width, height: height)
                        
                        buildFooter
                        
                        Spacer()
                        
                        buildComplimentButton(width: width)
                        
                        #if DEBUG
                        buildDebugButtons
                        #endif
                    }
                    
                    buildPopupView
                }
                .onChange(of: scenePhase) { _ in
                    viewModel.compareDates()
                    viewModel.updateCanBreakBoxes()
                }
                .onAppear {
                    let allComplimentsCount = viewModel.complimentsInGroupCount
                    viewModel.updateComplimentsGroupCount()
                    // 최초 칭찬 작성 시 안내 팝업
                    if allComplimentsCount == 1, viewModel.userRepository.isfirst == true {
                        withAnimation {
                            showInfoPopup = true
                        }
                    }
                }
                .alert(isPresented: $viewModel.showErrorAlert) {
                    Alert(title: Text("에러"), message: Text(viewModel.errorDescription), dismissButton: .default(Text("확인")))
                }
            }
        }
    }
    
    private var buildHeader: some View {
        HStack {
            Text("매주")
                .bold()
                .font(.body)
                .foregroundColor(.gray)
            Button(action: {
                viewModel.toggleShowActionSheet()
            }, label: {
                Text(viewModel.userRepository.selectedWeekday)
                    .bold()
                    .font(.body)
                    .foregroundColor(!viewModel.userRepository.isfirst ? .blue : .gray)
                    .padding(.trailing, -8.0)
                Image(systemName: "arrowtriangle.down.square.fill")
                    .foregroundColor(!viewModel.userRepository.isfirst ? .blue : .gray)
            })
            .disabled(viewModel.userRepository.isfirst)
            .padding(.horizontal)
            .actionSheet(isPresented: $viewModel.showActionSheet) {
                ActionSheet(title: Text("요일 변경"), message: nil, buttons: viewModel.weekdayActionButtons)
            }
            // 요일 변경할건지 얼럿
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("매주 \(viewModel.tempSeletedWeekday.rawValue)"),
                      message: Text("선택한 요일로 변경할까요?"),
                      primaryButton: .default(Text("네")) {
                    // OK 버튼을 눌렀을 때 선택한 요일 업데이트
                    viewModel.applyWeekdayChange()
                }, secondaryButton: .cancel(Text("아니요")))
            }
            .padding(.horizontal, -19.0)
            
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
    }
    
    private var buildDivider: some View {
        VStack(spacing: 0) {
            Divider()
            Rectangle()
                .fill(Color(.systemGray3))
                .frame(height: 5)
                .opacity(0.15)
            Divider()
        }
        .padding(.bottom, 30)
    }
    
    private var buildTitle: some View {
        Text(viewModel.userRepository.canBreakBoxes && viewModel.complimentBox.boxes.count > 0 ? "이번 주 칭찬을\n  확인할 시간이에요💞" : "오늘은 어떤 칭찬을\n해볼까요?✍️")
            .tracking(-0.3)
            .multilineTextAlignment(.center)
            .bold()
            .font(.title)
            .foregroundColor(Color("oll"))
            .lineSpacing(5)
            .padding(.bottom, 25)
    }
    
    private func buildComplimentBox(width: CGFloat, height: CGFloat) -> some View {
        SpriteView(scene: viewModel.complimentBox)
            .frame(width: width, height: height)
            .cornerRadius(26)
            .onTapGesture {
                if viewModel.complimentBox.boxes.count > 0 && viewModel.userRepository.canBreakBoxes {
                    viewModel.toggleShowBreakAlert()
                }
            }
            .overlay {
                if viewModel.complimentsInGroupCount == 0 && !viewModel.userRepository.isCompliment {
                    NavigationLink(destination: WriteComplimentView()) {
                        Image("emptyState")
                    }
                }
            }
        // 만기일 개봉 얼럿
            .alert(isPresented: $viewModel.showBreakAlert) {
                Alert(title: Text("칭찬 상자를 열어볼까요?"), primaryButton: .default(Text("네")) {
                    // 저금통 초기화
                    withAnimation(.easeOut(duration: 1)) {
                        showPopup = true
                        viewModel.openComplimentBox()
                    }
                }, secondaryButton:.cancel(Text("아니요")))
            }
            .modifier(ShakeEffect(delta: viewModel.shake))
            .onChange(of: viewModel.shake) { newValue in
                withAnimation(.easeOut(duration: 1.5)) {
                    if viewModel.userRepository.canBreakBoxes {
                        if viewModel.shake == 0 {
                            viewModel.shake = newValue
                        } else {
                            viewModel.shake = 0
                        }
                    }
                }
            }
            .onAppear {
                viewModel.prepareScene(width: width, height: height)
            }
    }
    
    private var buildFooter: some View {
        let text: String
        
        if viewModel.complimentsInGroupCount == 7 {
            text = "주간 칭찬은 최대 7개 까지만 가능해요."
        } else if viewModel.userRepository.canBreakBoxes && viewModel.complimentBox.boxes.count > 0 {
            text = "칭찬 상자를 톡! 눌러주세요."
        } else {
            text = "긍정의 힘은 복리로 돌아와요. 커밍쑨!"
        }
        return Text(text)
            .font(.system(size: 14, weight: .semibold))
            .foregroundStyle(.gray)
            .padding(.top, 14)
    }
    
    private func buildComplimentButton(width: CGFloat) -> some View {
        // 칭찬돌 추가하는 버튼
        Button(action: {
        }, label: {
            NavigationLink(destination: WriteComplimentView(), label: {
                Text(viewModel.userRepository.isCompliment ? "오늘 칭찬 끝!" : "칭찬하기")
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
                .foregroundColor(viewModel.userRepository.isCompliment || viewModel.complimentsInGroupCount == 7 ? Color.lightgray : .blue)
        }
        .disabled(viewModel.userRepository.isCompliment || viewModel.complimentsInGroupCount == 7)
    }
    
    private var buildPopupView: some View {
        Color.clear
            .popup(isPresented: $showPopup) {
                CardView(showPopup: $showPopup)
            }
            .popup(isPresented: $showInfoPopup) {
                InfoPopupView(showInfoPopup: $showInfoPopup)
            }
    }
    
    private var buildDebugButtons: some View {
        HStack {
            Button {
                CoreDataManager.shared.testAddCompliment()
            } label: {
                Text("7개 아카이빙에 추가")
            }

            Button {
                CoreDataManager.shared.testResetCoreData()
                CoreDataManager.shared.resetDatabase()
                viewModel.userRepository.isCompliment = false
            } label: {
                Text("초기화")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
