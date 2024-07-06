//
//  WeatherModel.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/4/24.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    let main: Main
    let weather: [WeatherCondition]
    let name: String

    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }

    struct WeatherCondition: Codable {
        let description: String
        let icon: String
    }
}

extension Color {
    static let darkGray = Color(red: 0.33, green: 0.33, blue: 0.33)
}

struct WeatherModel: Identifiable, Codable {
    var id = UUID()
    let locationName: String
    let temperature: String
    let condition: String
    let highsLows: String

    static func fromWeather(_ weather: Weather) -> WeatherModel {
        return WeatherModel(
            locationName: weather.name,
            temperature: "\(Int(weather.main.temp))°C",
            condition: weather.weather.first?.description.capitalized ?? "N/A",
            highsLows: "H: \(Int(weather.main.temp_max))°C, L: \(Int(weather.main.temp_min))°C"
        )
    }

    func getGradient() -> LinearGradient {
        switch condition.lowercased() {
        case "clear sky":
            return LinearGradient(
                gradient: Gradient(colors: [.blue, .cyan]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "few clouds":
            return LinearGradient(
                gradient: Gradient(colors: [.gray, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "scattered clouds":
            return LinearGradient(
                gradient: Gradient(colors: [.gray, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "broken clouds":
            return LinearGradient(
                gradient: Gradient(colors: [.darkGray, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "overcast clouds":
            return LinearGradient(
                gradient: Gradient(colors: [.gray, .darkGray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "shower rain", "light rain":
            return LinearGradient(
                gradient: Gradient(colors: [.gray, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "thunderstorm", "moderate rain", "heavy rain":
            return LinearGradient(
                gradient: Gradient(colors: [.darkGray, .black]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "snow":
            return LinearGradient(
                gradient: Gradient(colors: [.white, .blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        case "mist":
            return LinearGradient(
                gradient: Gradient(colors: [.gray, .white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        default:
            return LinearGradient(
                gradient: Gradient(colors: [.blue, .purple]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
    }

    func getIconName() -> String {
        switch condition.lowercased() {
        case "clear sky":
            return "sun.max.fill"
        case "few clouds":
            return "cloud.sun.fill"
        case "scattered clouds", "broken clouds", "overcast clouds":
            return "cloud.fill"
        case "shower rain", "rain":
            return "cloud.rain.fill"
        case "thunderstorm":
            return "cloud.bolt.fill"
        case "snow":
            return "snow"
        case "mist":
            return "cloud.fog.fill"
        default:
            return "cloud.fill"
        }
    }
}
