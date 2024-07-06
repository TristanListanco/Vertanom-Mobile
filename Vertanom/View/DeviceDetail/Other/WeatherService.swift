//
//  WeatherService.swift
//  Vertanom
//
//  Created by Tristan Listanco on 7/4/24.
//

import Foundation

class WeatherService {
    private let apiKey = "4d8ec8b29aa4490c3dc1475fa037f366"
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"

    func fetchWeather(latitude: Double, longitude: Double) async throws -> WeatherModel? {
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let weather = try JSONDecoder().decode(Weather.self, from: data)
        return WeatherModel.fromWeather(weather)
    }
}
