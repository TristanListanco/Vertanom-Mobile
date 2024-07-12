//
//  ViewExtension.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/11/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func conditionalNavigationBarTitleDisplayMode(_ displayMode: NavigationBarItem.TitleDisplayMode) -> some View {
        #if os(iOS)
        self.navigationBarTitleDisplayMode(displayMode)
        #else
        self
        #endif
    }
}
