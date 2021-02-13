//
//  QuranDBApp.swift
//  Shared
//
//  Created by Salman Bakhsh on 11/20/20.
//

import SwiftUI

@main
struct QuranDBApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.layoutDirection, .rightToLeft)
        }
    }
}
