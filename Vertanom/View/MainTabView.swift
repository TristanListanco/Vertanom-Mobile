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
            DashboardView()
                .tabItem { Label("Home", systemImage: "house") }
            Activity()
                .tabItem { Label("Activity", systemImage: "antenna.radiowaves.left.and.right.circle") }
            ArticleView()
                .tabItem { Label("Articles", systemImage: "newspaper") }
            About()
                .tabItem { Label("About", systemImage: "info.circle") }
        }
        .tabViewStyle(.sidebarAdaptable)
        
    }
}

#Preview {
    MainTabView()
}
