//
//  ContentView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

struct ContentView: View {
	
	@EnvironmentObject var viewModel: ComplimentViewModel
	@State private var hasOnboarded: Bool = UserDefaults.standard.bool(forKey: "HasOnboarded")
	@AppStorage("group") var groupOrder: Int = 1

	init() {
		UIView.appearance().overrideUserInterfaceStyle = .light
	}

	var body: some View {
		if hasOnboarded {
			MainView()
		} else {
            OnboardingView()
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
