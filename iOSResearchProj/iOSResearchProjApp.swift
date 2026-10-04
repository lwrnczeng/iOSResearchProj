//
//  iOSResearchProjApp.swift
//  iOSResearchProj
//
//  Created by Lawrence Zeng on 2026-08-02.
//

import SwiftUI
import SwiftData
import LiveCodingBlueprint

@main
struct iOSResearchProjApp: App {
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
            ProductListView() //CheckoutInputView() //BankingDashboardView()
        }
        .modelContainer(sharedModelContainer)
    }
}
