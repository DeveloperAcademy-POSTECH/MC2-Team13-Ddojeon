//
//  LottieView.swift
//  Chinggu
//
//  Created by BraveJ's on 2023/04/18.
//

import Lottie
import SwiftUI
import UIKit
 
struct LottieView : UIViewRepresentable {
    typealias UIViewType = UIView
    
    var filename: String
    var loopState: Bool
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        let view = UIView(frame: .zero)
        //4. Add animation
        let animationView = LottieAnimationView()
        //사용자 애니메이션 파일명
        animationView.animation = LottieAnimation.named(filename)
        //애니메이션 크기가 적절하게 조정될 수 있도록
        animationView.contentMode = .scaleAspectFit
        if loopState {
            animationView.loopMode = .loop
        }
        //애니메이션 재생
        animationView.play()
        
        //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        //5. 자동완성 기능
        NSLayoutConstraint.activate([
            //레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        
    }
}

struct LottiePlayState : UIViewRepresentable {
    
    func makeUIView(context: Context) -> Lottie.LottieAnimationView {
        let view = UIView(frame: .zero)
        //4. Add animation
        let animationView = LottieAnimationView()
        //사용자 애니메이션 파일명
        animationView.animation = LottieAnimation.named(filename)
        //애니메이션 크기가 적절하게 조정될 수 있도록
        animationView.contentMode = .scaleAspectFit
        if loopState {
            animationView.loopMode = .loop
        }
       
        
        //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        //5. 자동완성 기능
        NSLayoutConstraint.activate([
            //레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return animationView
    }
    
    func updateUIView(_ uiView: Lottie.LottieAnimationView, context: Context) {
        if playState {
            uiView.play()
        }
    }
    
    
     var filename: String
     var loopState: Bool
     @Binding var playState: Bool
    
    /*
     func makeUIView(context: UIViewRepresentableContext<LottieView>) -> LottieAnimationView {
         let view = UIView(frame: .zero)
         //4. Add animation
         let animationView = LottieAnimationView()
         //사용자 애니메이션 파일명
         animationView.animation = LottieAnimation.named(filename)
         //애니메이션 크기가 적절하게 조정될 수 있도록
         animationView.contentMode = .scaleAspectFit
         if loopState {
             animationView.loopMode = .loop
         }
        
         
         //컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
         animationView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(animationView)
         
         //5. 자동완성 기능
         NSLayoutConstraint.activate([
             //레이아웃의 높이와 넓이의 제약
             animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
             animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
         ])
         
         return animationView
     }
     
     func updateUIView(_ uiView: LottieAnimationView, context: UIViewRepresentableContext<LottieView>) {
         if playState {
             uiView.play()
         }
     }
     */
 }

