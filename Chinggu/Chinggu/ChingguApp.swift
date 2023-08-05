//
//  ChingguApp.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

@main
struct ChingguApp: App {
	
	init() { UIView.appearance().overrideUserInterfaceStyle = .light }
	
	let persistenceController = PersistenceController.shared
	
    var body: some Scene {
        WindowGroup {
            ContentView()
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
