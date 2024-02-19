//
//  ContentView.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

struct ContentView: View {
    @AppStorage(AppStorageKeys.hasOnboarded) var hasOnboarded: Bool = false
	
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
