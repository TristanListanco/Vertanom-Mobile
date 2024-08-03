//
//  DeviceSystemControlStatus.swift
//  Vertanom-Watch Watch App
//
//  Created by Tristan Listanco on 7/26/24.
//

import SwiftUI


struct DeviceSystemStatusControls: View {
    @State private var isDeviceOn: Bool = true

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                // Action to refresh the system
            }) {
                Label("Refresh Device", systemImage: "arrow.clockwise")
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)

            Button(role: .destructive, action: {
                // Action to reset the device
            }) {
                Label("Reset", systemImage: "trash")
            }
            .buttonStyle(.bordered)
            .tint(.red)
        }
        .padding()
        .navigationTitle("System")
    }
}

#Preview {
    DeviceSystemStatusControls()
}
