//
//  iTourApp.swift
//  iTour
//
//  Created by Brandon Johns on 7/9/24.
//

import SwiftData
import SwiftUI


@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        Label("Destinations", systemImage: "map")
                    }
                
                SightsView()
                    .tabItem {
                        Label("Sights", systemImage: "mappin.and.ellipse")
                    }
            }
        }
                .modelContainer(for: Destination.self)
    }
}
