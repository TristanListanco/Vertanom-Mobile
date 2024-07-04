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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    WeatherCard()
                    .padding([.top, .bottom], 16) // Padding of 20 points to horizontal, top, and bottom

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
                            DeviceCard(viewModel: viewModel)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity) // Ensures the VStack stretches to fill the ScrollView's width
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isProfileViewPresented = true
                    }) {
                        Image(systemName: "person.crop.circle")
                            .imageScale(.large)
                            .foregroundStyle(Color.purple)
                            .font(.system(size: 24))
                    }
                }
            }
            .sheet(isPresented: $isProfileViewPresented) {
                NavigationView {
                    Profile(viewModel: viewModel)
                        .presentationSizing(.form)
                        .navigationBarTitle("Profile", displayMode: .inline)
                        .navigationBarItems(trailing: Button("Done") {
                            isProfileViewPresented = false
                        })
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
