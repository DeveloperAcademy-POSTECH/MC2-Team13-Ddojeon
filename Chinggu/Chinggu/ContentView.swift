//
//  ContentView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

struct ContentView: View {
	
	init() {
		UIView.appearance().overrideUserInterfaceStyle = .light
	}
	
	@State private var hasOnboarded: Bool = UserDefaults.standard.bool(forKey: "HasOnboarded")

	var body: some View {
//		if hasOnboarded {
			MainView()
//		} else {
//			NavigationView {
//				NavigationLink(
//					destination: Onboarding_1(),
//					label: {
//						Text("다음")
//							.font(.custom("AppleSDGothicNeo-Bold", size: 20))
//							.foregroundColor(Color.black)
//							.kerning(1)
//							.padding(.horizontal, 145)
//							.padding(.vertical,6)
//					})
//			}.navigationBarHidden(true)
//		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
