//
//  DeveloperPreview.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import Foundation

class DeveloperPreview {
    static let shared = DeveloperPreview()

    // Generate dummy user profile data
    func dummyUserProfile() -> UserProfile {
        return UserProfile(
            id: UUID(),
            name: "John Doe",
            ownerImageUrl: "https://example.com/johndoe.jpg",
            email: "john.doe@example.com",
            address: "123 Main St",
            numberOfDevices: 3,
            password: "password123",
            hobbies: ["Reading", "Hiking", "Coding"]
        )
    }

    // Example method to create a view model with dummy data
    func dummyUserProfileViewModel() -> UserProfileViewModel {
        let userProfile = dummyUserProfile()
        return UserProfileViewModel(userProfile: userProfile)
    }

    // Generate dummy device data
    func dummyDevice(id: String, name: String, location: String, lastUpdated: String, status: String) -> Device {
        return Device(
            id: id,
            name: name,
            location: location,
            lastUpdated: lastUpdated,
            status: status
        )
    }

    // Generate an array of dummy devices
    func dummyDevices() -> [Device] {
        return [
            dummyDevice(id: UUID().uuidString, name: "Sunnybrook Farm", location: "San Francisco", lastUpdated: "10:00 AM", status: "RUNNING"),
            dummyDevice(id: UUID().uuidString, name: "Greenfield Farm", location: "New York", lastUpdated: "11:30 AM", status: "IDLE"),
            dummyDevice(id: UUID().uuidString, name: "Maplewood Farm", location: "Los Angeles", lastUpdated: "12:45 PM", status: "RUNNING"),
            dummyDevice(id: UUID().uuidString, name: "Willow Creek Farm", location: "Chicago", lastUpdated: "09:15 AM", status: "OFF"),
            dummyDevice(id: UUID().uuidString, name: "Oakridge Farm", location: "Seattle", lastUpdated: "08:00 AM", status: "RUNNING"),
            dummyDevice(id: UUID().uuidString, name: "Pine Hill Farm", location: "Austin", lastUpdated: "07:45 AM", status: "LOCKED")
        ]
    }

    // Example method to create an array of view models with dummy device data
    func dummyDeviceViewModels() -> [DeviceViewModel] {
        return dummyDevices().map { DeviceViewModel(device: $0) }
    }
}
