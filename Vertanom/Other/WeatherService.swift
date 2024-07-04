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

    func fetchWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?) -> Void) {
        let urlString = "\(baseURL)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let weather = try? JSONDecoder().decode(Weather.self, from: data)
            DispatchQueue.main.async {
                if let weather = weather {
                    completion(WeatherModel.fromWeather(weather))
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}
