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
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.device.name)
                        .font(.title3)
                        .fontWeight(.bold)

                    Text(viewModel.device.location)
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    Spacer().frame(height: 16)

                    Label(viewModel.device.location, systemImage: "location.fill")

                    Text("Last Time Updated: \(viewModel.device.lastUpdated)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(viewModel.device.status)
                        .font(.footnote)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(statusColor)
                        .clipShape(Capsule())
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(minHeight: 150) // Ensure a minimum height but allow it to grow
            .background(Color(UIColor.secondarySystemBackground))
            .clipShape(RoundedRectangle(cornerRadius: 15))
        }
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
