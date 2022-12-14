//
//  SeventyFiveGrandApp.swift
//  SeventyFiveGrand
//
//  Created by Jerome Paulos on 12/14/22.
//

import SwiftUI

@main
struct SeventyFiveGrandApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .tint(.cyan)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
