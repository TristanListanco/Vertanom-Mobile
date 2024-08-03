import SwiftUI
import TipKit

struct DashboardView: View {
    @State private var isProfileViewPresented = false
    @Namespace var namespace
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isArticleViewPresented = false
    @State private var isAddDeviceViewPresented = false
    @State private var selectedArticle: Article?
    @State private var selectedDevice: DeviceViewModel?
    @State private var searchQuery = ""
    let viewModel = DeveloperPreview.shared.dummyUserProfileViewModel()
    @State private var deviceViewModels = DeveloperPreview.shared.dummyDeviceViewModels()

    var filteredDeviceViewModels: [DeviceViewModel] {
        if searchQuery.isEmpty {
            return deviceViewModels
        } else {
            return deviceViewModels.filter {
                $0.device.name.localizedCaseInsensitiveContains(searchQuery) ||
                    $0.device.location.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List {
                Section {
                    ForEach(filteredDeviceViewModels, id: \.device.id) { viewModel in
                        DeviceCard(viewModel: viewModel)
                            .contextMenu {
                                Button(action: {
                                    // Action for editing the device
                                    selectedDevice = viewModel
                                    isAddDeviceViewPresented = true
                                }) {
                                    Label("Edit Device", systemImage: "pencil")
                                }
                                Button(role: .destructive, action: {
                                    // Action for deleting the device
                                    if let index = deviceViewModels.firstIndex(where: { $0.device.id == viewModel.device.id }) {
                                        deviceViewModels.remove(at: index)
                                    }
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Devices")

        } detail: {
            if let selectedDevice = selectedDevice {
                DeviceDetailView(deviceViewModel: selectedDevice)
            } else {
                Text("Select a device")
            }
        }
        .searchable(text: $searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        .sheet(isPresented: $isAddDeviceViewPresented) {
            NavigationView {
                AddDeviceView(isPresented: $isAddDeviceViewPresented, device: $selectedDevice)
                    .presentationSizing(.form)
#if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)
#endif
            }
        }
    }
}
