//
//  ContentView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

struct ContentView: View {
	
//	@State private var hasOnboarded: Bool = UserDefaults.standard.bool(forKey: UserDefaultsKeys.hasOnboarded)
	@AppStorage(UserDefaultsKeys.hasOnboarded) private var hasOnboarded: Bool = false
	@AppStorage(UserDefaultsKeys.groupOrder) var groupOrder: Int = 1
	
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
