//
//  MainTabView.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/29/24.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house") {
                DashboardView()
            }
            Tab("Activity", systemImage: "gauge.with.needle") {
                Activity()
            }
            Tab("About", systemImage: "info.circle") {
                About()
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainTabView()
}
