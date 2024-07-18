//
//  VertanomApp.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/29/24.
//

import SwiftUI
import TipKit

@main
struct VertanomApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    // Configure and load your tips at app launch.
                    do {
                        try Tips.configure([
                            .displayFrequency(.immediate),
                            .datastoreLocation(.applicationDefault)
                        ])
                        try? Tips.resetDatastore()
                    }
                    catch {
                        // Handle TipKit errors
                        print("Error initializing TipKit \(error.localizedDescription)")
                    }
                }
        }
    }
}
