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
		if hasOnboarded {
			MainView()
		} else {
			Onboarding_1()
		}
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
    }
}
