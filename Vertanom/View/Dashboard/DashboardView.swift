import Charts
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
    let viewModel = DeveloperPreview.shared.dummyUserProfileViewModel()
    let deviceViewModels = DeveloperPreview.shared.dummyDeviceViewModels()
    let articles = DeveloperPreview.shared.dummyArticles()

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 16) {
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
                                    }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                    Text("Articles")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.trailing)
                    let articleColumns: [GridItem] = horizontalSizeClass == .compact
                        ? [GridItem(.adaptive(minimum: .infinity))]
                        : [GridItem(.adaptive(minimum: 240), spacing: 16)]

                    LazyVGrid(columns: articleColumns, spacing: 16) {
                        ForEach(articles) { article in
                            ArticlesCardView(article: article, namespace: namespace)
                                .onTapGesture {
                                    selectedArticle = article
                                    isArticleViewPresented = true
                                }
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
            .sheet(isPresented: $isAddDeviceViewPresented) {
                NavigationView {
                    AddDeviceView(isPresented: $isAddDeviceViewPresented, device: $selectedDevice)
                        .presentationSizing(.form)
                    #if os(iOS)
                        .navigationBarTitleDisplayMode(.inline)
                    #endif
                }
            }
            .sheet(item: $selectedArticle) { article in
                ArticleDetailView(article: article, isPresented: $isArticleViewPresented)
                #if os(iOS)
                    .navigationBarTitleDisplayMode(.inline)
                #endif
                    .presentationSizing(.form)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isProfileViewPresented = false
                            }
                        }
                    }
                    .navigationTitle("Sample")
                    .onDisappear {
                        selectedArticle = nil // Reset selected article when view disappears
                    }
            }
        }
    }
}

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
        .navigationTitle("Add Device")
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    // Save action
                    isPresented = false
                }
            }
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    isPresented = false
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .task {
            // Configure and load your tips at app launch.
            do {
                try? Tips.resetDatastore()
                try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                ])
            }
            catch {
                // Handle TipKit errors
                print("Error initializing TipKit \(error.localizedDescription)")
            }
        }
}
