//
//  _th_SwiftUI_SwiftDataApp.swift
//  5th-SwiftUI-SwiftData
//
//  Created by 이유현 on 3/2/25.
//

import SwiftUI
import SwiftData

@main
struct _th_SwiftUI_SwiftDataApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
