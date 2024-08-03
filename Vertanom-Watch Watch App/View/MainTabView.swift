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
                .containerBackground(Color.accentColor.gradient, for: .tabView)               
        }
    }
}

#Preview {
    MainTabView()
}
