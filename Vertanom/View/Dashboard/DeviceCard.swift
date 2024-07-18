import SwiftUI

struct DeviceCard: View {
    @ObservedObject var viewModel: DeviceViewModel
    var namespace: Namespace.ID

    var body: some View {
        NavigationLink(destination: DeviceDetailView(deviceViewModel: viewModel)) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(viewModel.device.name)
                        .font(.title3)
                        .fontWeight(.bold)

                    HStack(spacing: 4) {
                        Image(systemName: "location.fill")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        Text(viewModel.device.location)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer().frame(height: 16)

                    Text("Last Time Updated: \(viewModel.device.lastUpdated)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(viewModel.device.status.rawValue)
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
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor)
            )
            .frame(maxWidth: .infinity)
            .frame(minHeight: 140) // Ensure a minimum height but allow it to grow
            .matchedGeometryEffect(id: viewModel.device.id, in: namespace)
            #if !os(macOS)
                .navigationTransition(.zoom(sourceID: viewModel.device.id, in: namespace))
                .matchedTransitionSource(id: viewModel.device.id, in: namespace)
            #endif
        }
    }

    // Computed property to determine the background color based on the status
    private var statusColor: Color {
        switch viewModel.device.status {
        case .online:
            return .green
        case .idle:
            return .yellow
        case .offline:
            return .red
        default:
            return .gray
        }
    }

    // Computed property to determine the background color based on the platform
    private var backgroundColor: Color {
        #if os(iOS) || os(tvOS)
            return Color(.secondarySystemBackground)
        #elseif os(macOS)
            return Color(NSColor.windowBackgroundColor)
        #endif
    }
}

struct DeviceCard_Previews: PreviewProvider {
    static var previews: some View {
        let sampleDevice = Device(
            id: "1",
            name: "Example Device",
            location: "Sample Location",
            lastUpdated: "10:00 AM",
            status: DeviceStatus(rawValue: DeviceStatus.online.rawValue) ?? .idle,
            temperature: 25.0,
            pH: 7.0,
            humidity: 60.0,
            soilNutrient: 0.5
        )

        let viewModel = DeviceViewModel(device: sampleDevice)
        @Namespace var namespace

        return DeviceCard(viewModel: viewModel, namespace: namespace)
    }
}
