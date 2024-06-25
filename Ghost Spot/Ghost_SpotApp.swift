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
            TabView {
                ContentView()
                    .tabItem {
                        Label("List", systemImage: "list.dash")
                    }

                NavigationView {
                    MapView()
                }
                .tabItem {
                    Label("Map", systemImage: "map")
                }
            }                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
