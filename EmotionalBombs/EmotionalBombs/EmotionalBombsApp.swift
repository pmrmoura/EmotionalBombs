//
//  EmotionalBombsApp.swift
//  EmotionalBombs
//
//  Created by Pedro Moura on 05/07/21.
//

import SwiftUI

@main
struct EmotionalBombsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
