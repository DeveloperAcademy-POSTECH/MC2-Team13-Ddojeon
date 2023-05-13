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
	
    var body: some View {
		MainView()
        /*olling
         NavigationView {
             NavigationLink(
                     destination: Onboarding_1(),label: {
                         Text("다음")
                             .font(.custom("AppleSDGothicNeo-Bold", size: 20))
                             .foregroundColor(Color.black)
                             .kerning(1)
                             .padding(.horizontal, 145)
                             .padding(.vertical,6)
                     })
         }.navigationBarHidden(true)
         */
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
