//
//  Ghost_SpotApp.swift
//  Ghost Spot
//
//  Created by Zack Edds on 6/24/24.
//

import SwiftUI

@main
struct Ghost_SpotApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
