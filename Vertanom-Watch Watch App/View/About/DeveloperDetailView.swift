//
//  DeveloperDetailView.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import SwiftUI

struct DeveloperDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let developer: Developers
    var body: some View {
        VStack {
            Spacer()
            Text("Developer Detail")
                .font(.title)
            Text("Name: \(developer.name)")
            Text("URL: \(developer.url)")
            Spacer()
        }
        .padding()
    }
}

#Preview {
    DeveloperDetailView(developer: Developers(name: "Tristan", url: "http"))
}
