//
//  GridDesigningApp.swift
//  GridDesigning
//
//  Created by Benjamin Patch on 1/19/25.
//

import SwiftUI
import SwiftData

@main
struct GridDesigningApp: App {
    static var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Pegboard.self,
            _UserColorPallette.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    static var context: ModelContext { sharedModelContainer.mainContext }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(Self.sharedModelContainer)
    }
}
