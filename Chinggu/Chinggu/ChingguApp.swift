//
//  ChingguApp.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

@main
struct ChingguApp: App {
	
	@StateObject var viewModel = ComplimentViewModel(persistenceController: PersistenceController.shared)

	var body: some Scene {
		WindowGroup {
			ContentView()
				.environmentObject(viewModel)
		}
	}
}
