//
//  AddDevice.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/7/24.
//

import SwiftUI
import TipKit

struct AddDeviceView: View {
    @Binding var isPresented: Bool
    @Binding var device: DeviceViewModel?
    let deviceInstructions = DeviceInstructions()
    @State private var deviceName: String = ""
    @State private var deviceLocation: String = ""

    var body: some View {
        VStack {
            TipView(deviceInstructions)
            Form {
                Section {
                    TextField("Device Name", text: $deviceName)
                    TextField("Location", text: $deviceLocation)
                }
            }
        }
        .padding()
        .navigationTitle(device == nil ? "Add Device" : "Edit Device")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // Save action
                    if let device = device {
                        // Update existing device
                        device.device.name = deviceName
                        device.device.location = deviceLocation
                    } else {
                        // Add new device
                        // Add logic to save new device
                    }
                    isPresented = false
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    isPresented = false
                }
            }
        }
        .onAppear {
            if let device = device {
                deviceName = device.device.name
                deviceLocation = device.device.location
            }
        }
    }
}
