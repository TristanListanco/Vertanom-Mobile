//
//  UserViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import Foundation

class UserProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile

    init(userProfile: UserProfile) {
        self.userProfile = userProfile
    }

    // Update user profile properties
    func updateName(_ newName: String) {
        userProfile.name = newName
    }

    func updateEmail(_ newEmail: String) {
        userProfile.email = newEmail
    }

    func updateAddress(_ newAddress: String) {
        userProfile.address = newAddress
    }

    func updateNumberOfDevices(_ newNumberOfDevices: Int) {
        userProfile.numberOfDevices = newNumberOfDevices
    }

    func updatePassword(_ newPassword: String) {
        userProfile.password = newPassword
    }

    func updateHobbies(_ newHobbies: [String]) {
        userProfile.hobbies = newHobbies
    }

    func updateOwnerImageUrl(_ newOwnerImageUrl: String) {
        userProfile.ownerImageUrl = newOwnerImageUrl
    }

    // Update devices
    func addDevice(_ device: Device) async {
        await MainActor.run {
            userProfile.devices.append(device)
            userProfile.numberOfDevices = userProfile.devices.count
        }
    }

    func updateDevice(_ updatedDevice: Device) async {
        if let index = userProfile.devices.firstIndex(where: { $0.id == updatedDevice.id }) {
            await MainActor.run {
                userProfile.devices[index] = updatedDevice
            }
        }
    }

    func removeDevice(withId id: String) async {
        await MainActor.run {
            userProfile.devices.removeAll { $0.id == id }
            userProfile.numberOfDevices = userProfile.devices.count
        }
    }

    // Update device sensor data
    func updateDeviceSensorData(deviceId: String, temperatureData: [SensorValue]?, pHData: [SensorValue]?, humidityData: [SensorValue]?, soilNutrientData: [SensorValue]?) async {
        if let index = userProfile.devices.firstIndex(where: { $0.id == deviceId }) {
            await MainActor.run {
                if let temperatureData = temperatureData {
                    userProfile.devices[index].temperatureData = temperatureData
                }
                if let pHData = pHData {
                    userProfile.devices[index].pHData = pHData
                }
                if let humidityData = humidityData {
                    userProfile.devices[index].humidityData = humidityData
                }
                if let soilNutrientData = soilNutrientData {
                    userProfile.devices[index].soilNutrientData = soilNutrientData
                }
            }
        }
    }
}
