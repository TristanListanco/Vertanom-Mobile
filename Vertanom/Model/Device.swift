//
//  Device.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/18/24.
//

import Foundation

import Foundation

enum DeviceStatus: String, Codable {
    case online = "ONLINE"
    case offline = "OFFLINE"
    case idle = "IDLE"
    case unknown // Default case
}

struct Device: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var location: String
    var lastUpdated: String
    var status: DeviceStatus
    var temperature: Double // Temperature sensor value
    var pH: Double // pH sensor value
    var humidity: Double // Humidity sensor value
    var soilNutrient: Double // Soil nutrient sensor value
}
