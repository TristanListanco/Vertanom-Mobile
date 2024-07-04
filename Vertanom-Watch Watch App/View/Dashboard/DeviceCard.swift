//
//  DeviceCard.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/1/24.
//

import SwiftUI

struct DeviceCard: View {
    @ObservedObject var viewModel: DeviceViewModel
    var body: some View {
        NavigationLink(destination: DeviceDetailView(deviceViewModel: viewModel)) {
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.device.name)
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundColor(.primary) // Adjust text color

                Text(viewModel.device.location)
                    .font(.subheadline)
                    .foregroundColor(.secondary) // Adjust text color

                Label(viewModel.device.location, systemImage: "location.fill")
                    .foregroundColor(.secondary) // Adjust text color
                    .font(.caption)
                VStack {
                    Text(viewModel.device.status)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(statusColor)
                        .clipShape(Capsule())
                }
                .padding(.vertical)
            }
            .padding(.vertical, 4)
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        .frame(maxWidth: .infinity, alignment: .leading) // Make the VStack take full width and align leading
        .frame(minHeight: 100)
    }

    // Computed property to determine the background color based on the status
    private var statusColor: Color {
        switch viewModel.device.status.lowercased() {
        case "running":
            return .green
        case "idle":
            return .yellow
        case "offline":
            return .red
        case "maintenance":
            return .orange
        case "locked":
            return .blue
        default:
            return .gray
        }
    }
}

#Preview {
    let sampleDevice = Device(
        id: "12345",
        name: "Weather Station",
        location: "San Francisco",
        lastUpdated: "10:00 AM",
        status: "RUNNING"
    )

    let viewModel = DeviceViewModel(device: sampleDevice)

    return DeviceCard(viewModel: viewModel)
}
