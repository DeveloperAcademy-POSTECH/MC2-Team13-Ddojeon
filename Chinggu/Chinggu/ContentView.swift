//
//  ContentView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

struct ContentView: View {
	
	@AppStorage(UserDefaultsKeys.hasOnboarded) private var hasOnboarded: Bool = false	
	@StateObject private var mainStore = MainStore()

	var body: some View {
		if hasOnboarded {
			MainView()
				.environmentObject(mainStore)
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
