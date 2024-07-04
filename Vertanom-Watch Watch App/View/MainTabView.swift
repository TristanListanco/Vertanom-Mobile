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
            About()
                .tabItem { Label("About", systemImage: "info.circle") }
        }

    }
}

#Preview {

    MainTabView()
}
