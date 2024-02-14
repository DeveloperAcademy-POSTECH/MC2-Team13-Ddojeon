//
//  ChingguApp.swift
//  Chinggu
//
//  Created by Sebin Kwon on 2023/05/04.
//

import SwiftUI

@main
struct ChingguApp: App {
	
    let coreDataManager = CoreDataManager.shared
	
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, coreDataManager.container.viewContext)
        }
    }
}
