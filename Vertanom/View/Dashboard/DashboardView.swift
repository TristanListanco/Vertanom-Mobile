import Charts
import SwiftUI

struct DashboardView: View {
    @State private var isProfileViewPresented = false
    @Namespace var namespace
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    let viewModel = DeveloperPreview.shared.dummyUserProfileViewModel()
    let deviceViewModels = DeveloperPreview.shared.dummyDeviceViewModels()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    WeatherCard()
                        .padding([.top, .bottom], 16)

                    Text("Devices")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing)

                    let columns: [GridItem] = horizontalSizeClass == .compact
                        ? [GridItem(.adaptive(minimum: .infinity))]
                        : [GridItem(.adaptive(minimum: 240), spacing: 16)]

                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(deviceViewModels, id: \.device.id) { viewModel in
                            DeviceCard(viewModel: viewModel, namespace: namespace)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
            }
            .navigationDestination(for: Device.self) { device in
                DeviceDetailView(deviceViewModel: DeviceViewModel(device: device))
            }
            .navigationTitle("Dashboard")
            .toolbar {
                #if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isProfileViewPresented = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                            .foregroundStyle(Color(.systemPurple))
                            .font(.system(size: 24))
                    }
                }
                #elseif os(macOS)
                ToolbarItem(placement: .automatic) {
                    Spacer()
                }
                ToolbarItem(placement: .automatic) {
                    Button(action: {
                        isProfileViewPresented = true
                    }) {
                        Label("Profile", systemImage: "person.crop.circle")
                            .imageScale(.large)
                            .foregroundStyle(Color(NSColor.systemPurple))
                            .font(.system(size: 24))
                    }
                }
                #endif
            }
            .sheet(isPresented: $isProfileViewPresented) {
                NavigationView {
                    Profile(viewModel: viewModel)
                        .presentationSizing(.form)
                        .navigationTitle("Profile")
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isProfileViewPresented = false
                                }
                            }
                        }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
