//
//  DeviceViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/2/24.
//

import Combine
import Foundation

class DeviceViewModel: ObservableObject {
    @Published var device: Device

    init(device: Device) {
        self.device = device
    }

    // Update device properties
    func updateName(_ newName: String) {
        device.name = newName
    }

    func updateLocation(_ newLocation: String) {
        device.location = newLocation
    }

    func updateLastUpdated(_ newLastUpdated: String) {
        device.lastUpdated = newLastUpdated
    }

    // Update status with a String value
    func updateStatus(_ newStatus: String) {
        device.status = DeviceStatus(rawValue: newStatus) ?? .unknown
    }

    // Update sensor values
    func updateTemperature(_ newTemperature: Double) {
        device.temperature = newTemperature
    }

    func updatePH(_ newPH: Double) {
        device.pH = newPH
    }

    func updateHumidity(_ newHumidity: Double) {
        device.humidity = newHumidity
    }

    func updateSoilNutrient(_ newSoilNutrient: Double) {
        device.soilNutrient = newSoilNutrient
    }
}
