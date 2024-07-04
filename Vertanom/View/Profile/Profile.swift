//
//  Profile.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import SwiftUI

struct Profile: View {
    // @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: UserProfileViewModel

    var body: some View {
        VStack {
            Image("male-profile-photo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            Text(viewModel.userProfile.name)
                .font(.largeTitle)
            Text(viewModel.userProfile.email)
                .font(.footnote)
                .fontWeight(.medium)
            Form {
                Section("Basic Information") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Address")
                            .font(.footnote)
                            .foregroundStyle(Color(UIColor.systemPurple))

                        Text(viewModel.userProfile.address)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Number of Devices")
                            .font(.footnote)
                            .foregroundStyle(Color(UIColor.systemPurple))

                        Text(viewModel.userProfile.numberOfDevices.formatted() + " Devices")
                    }
                }
                Section("Farm Details") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Farm Address")
                            .font(.footnote)
                            .foregroundStyle(Color(UIColor.systemPurple))

                        Text(viewModel.userProfile.address)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Type of Crop")
                            .font(.footnote)
                            .foregroundStyle(Color(UIColor.systemPurple))

                        Text(viewModel.userProfile.numberOfDevices.formatted() + " Devices")
                    }
                }
            }
            .formStyle(.grouped)

            Button(action: {
                viewModel.updateName("New Name")
                // Call other update methods as needed
            }) {
                Text("Update Profile")
                    .foregroundStyle(Color(UIColor.systemPurple))
            }
        }
        .padding()
    }
}

#Preview {
    let viewModel = DeveloperPreview.shared.dummyUserProfileViewModel()

    Profile(viewModel: viewModel)
}
