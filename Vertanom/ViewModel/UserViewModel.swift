//
//  UserViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 6/30/24.
//

import Combine
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
    func addDevice(_ device: Device) {
        userProfile.devices.append(device)
        userProfile.numberOfDevices = userProfile.devices.count
    }

    func updateDevice(_ updatedDevice: Device) {
        if let index = userProfile.devices.firstIndex(where: { $0.id == updatedDevice.id }) {
            userProfile.devices[index] = updatedDevice
        }
    }

    func removeDevice(withId id: String) {
        userProfile.devices.removeAll { $0.id == id }
        userProfile.numberOfDevices = userProfile.devices.count
    }

    // Update device sensor values
    func updateDeviceSensor(deviceId: String, temperature: Double?, pH: Double?, humidity: Double?, soilNutrient: Double?) {
        if let index = userProfile.devices.firstIndex(where: { $0.id == deviceId }) {
            if let temperature = temperature {
                userProfile.devices[index].temperature = temperature
            }
            if let pH = pH {
                userProfile.devices[index].pH = pH
            }
            if let humidity = humidity {
                userProfile.devices[index].humidity = humidity
            }
            if let soilNutrient = soilNutrient {
                userProfile.devices[index].soilNutrient = soilNutrient
            }
        }
    }
}
