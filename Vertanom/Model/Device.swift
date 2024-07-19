//
//  Device.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/18/24.
//

import Foundation

enum DeviceStatus: String, Codable {
    case online = "ONLINE"
    case offline = "OFFLINE"
    case idle = "IDLE"
    case unknown // Default case
}

struct SensorValue: Identifiable, Codable, Hashable {
    let date: Date
    var value: Int
    var id: Date { date }
}

struct Device: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var location: String
    var lastUpdated: String
    var status: DeviceStatus
    var temperatureData: [SensorValue]
    var pHData: [SensorValue]
    var humidityData: [SensorValue]
    var soilNutrientData: [SensorValue]
}
