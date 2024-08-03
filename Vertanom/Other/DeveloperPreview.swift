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
            hobbies: ["Reading", "Hiking", "Coding"],
            devices: dummyDevices()
        )
    }

    // Example method to create a view model with dummy data
    func dummyUserProfileViewModel() -> UserProfileViewModel {
        let userProfile = dummyUserProfile()
        return UserProfileViewModel(userProfile: userProfile)
    }

    // Generate dummy device data with sensor values
    func dummyDevice(id: String, name: String, location: String, lastUpdated: String, status: DeviceStatus) -> Device {
        return Device(
            id: id,
            name: name,
            location: location,
            lastUpdated: lastUpdated,
            status: status,
            temperatureData: generateSensorValues(),
            pHData: generateSensorValues(),
            humidityData: generateSensorValues(),
            soilNutrientData: generateSensorValues()
        )
    }

    // Generate an array of dummy devices with sensor values
    func dummyDevices() -> [Device] {
        return [
            dummyDevice(id: UUID().uuidString, name: "SunnyBrook Farm", location: "Lanao del Norte, Philippines", lastUpdated: "10:00 AM", status: .online),
            dummyDevice(id: UUID().uuidString, name: "Greenfield Farm", location: "Iligan City, Philippines", lastUpdated: "11:30 AM", status: .idle),
            dummyDevice(id: UUID().uuidString, name: "Bamban Farm", location: "Misamis Oriental, Philippines", lastUpdated: "12:45 PM", status: .online),
            dummyDevice(id: UUID().uuidString, name: "Willow Creek Farm", location: "Chicago", lastUpdated: "09:15 AM", status: .offline),
            dummyDevice(id: UUID().uuidString, name: "Oakridge Farm", location: "Seattle", lastUpdated: "08:00 AM", status: .online),
            dummyDevice(id: UUID().uuidString, name: "Pine Hill Farm", location: "Austin", lastUpdated: "07:45 AM", status: .offline)
        ]
    }

    // Example method to create an array of view models with dummy device data
    func dummyDeviceViewModels() -> [DeviceViewModel] {
        return dummyDevices().map { DeviceViewModel(device: $0) }
    }


    // Helper method to create a date object
    private func date(_ year: Int, _ month: Int, _ day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components) ?? Date()
    }

    // Helper method to generate random sensor values
    private func generateSensorValues() -> [SensorValue] {
        let startDate = date(2023, 1, 1)
        return (0..<10).map { i in
            let day = Calendar.current.date(byAdding: .day, value: i, to: startDate) ?? startDate
            return SensorValue(date: day, value: Double.random(in: 0...100))
        }
    }
}
