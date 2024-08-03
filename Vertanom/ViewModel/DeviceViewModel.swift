//
//  DeviceViewModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/2/24.
//

import Foundation

class DeviceViewModel: ObservableObject, Hashable, Equatable {
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

    // Update sensor data
    func updateTemperatureData(_ newData: [SensorValue]) {
        device.temperatureData = newData
    }

    func updatePHData(_ newData: [SensorValue]) {
        device.pHData = newData
    }

    func updateHumidityData(_ newData: [SensorValue]) {
        device.humidityData = newData
    }

    func updateSoilNutrientData(_ newData: [SensorValue]) {
        device.soilNutrientData = newData
    }

    // Add a new sensor value
    func addTemperatureData(_ newValue: SensorValue) {
        device.temperatureData.append(newValue)
    }

    func addPHData(_ newValue: SensorValue) {
        device.pHData.append(newValue)
    }

    func addHumidityData(_ newValue: SensorValue) {
        device.humidityData.append(newValue)
    }

    func addSoilNutrientData(_ newValue: SensorValue) {
        device.soilNutrientData.append(newValue)
    }

    // Equatable conformance
    static func == (lhs: DeviceViewModel, rhs: DeviceViewModel) -> Bool {
        return lhs.device.id == rhs.device.id
    }

    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(device.id)
    }
}
