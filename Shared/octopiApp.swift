//
//  octopiApp.swift
//  Shared
//
//  Created by Jony Money on 12/6/20.
//

import SwiftUI

@main
struct octopiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
