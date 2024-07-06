import SwiftUI

struct DeviceCard: View {
    @ObservedObject var viewModel: DeviceViewModel
    var namespace: Namespace.ID

    var body: some View {
        NavigationLink(value: viewModel.device) {
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
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(backgroundColor)
            )
            .frame(maxWidth: .infinity)
            .frame(minHeight: 150) // Ensure a minimum height but allow it to grow
            .matchedGeometryEffect(id: viewModel.device.id, in: namespace)
            #if !os(macOS)
            .navigationTransition(.zoom(sourceID: viewModel.device.id, in: namespace))
            .matchedTransitionSource(id: viewModel.device.id, in: namespace)
            #endif
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

    // Computed property to determine the background color based on the platform
    private var backgroundColor: Color {
        #if os(iOS) || os(tvOS)
        return Color(.secondarySystemBackground)
        #elseif os(macOS)
        return Color(NSColor.windowBackgroundColor)
        #endif
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
    @Namespace var namespace

    return DeviceCard(viewModel: viewModel, namespace: namespace)
}
