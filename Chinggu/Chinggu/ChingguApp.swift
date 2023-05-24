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
				.environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
				.environmentObject(viewModel)
		}
	}
}
