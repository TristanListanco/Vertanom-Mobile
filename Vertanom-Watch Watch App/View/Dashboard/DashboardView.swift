import Charts
import SwiftUI

struct DashboardView: View {
    @State private var isProfileViewPresented = false
    @Namespace() var namespace
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let viewModel = DeveloperPreview.shared.dummyUserProfileViewModel()
    let deviceViewModels = DeveloperPreview.shared.dummyDeviceViewModels()
    var body: some View {
        NavigationStack {
            List(deviceViewModels, id: \.device.id) { viewModel in
                DeviceCard(viewModel: viewModel)
                    // Remove default padding
                    .frame(maxWidth: .infinity) // Make the DeviceCard take full width
            }
            .listStyle(PlainListStyle()) // Remove default list styling
            .navigationTitle("Dashboard")
        }
    }
}

#Preview {
    DashboardView()
}
