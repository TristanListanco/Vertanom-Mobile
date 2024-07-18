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
    func dummyDevice(id: String, name: String, location: String, lastUpdated: String, status: DeviceStatus, temperature: Double, pH: Double, humidity: Double, soilNutrient: Double) -> Device {
        return Device(
            id: id,
            name: name,
            location: location,
            lastUpdated: lastUpdated,
            status: status,
            temperature: temperature,
            pH: pH,
            humidity: humidity,
            soilNutrient: soilNutrient
        )
    }

    // Generate an array of dummy devices with sensor values
    func dummyDevices() -> [Device] {
        return [
            dummyDevice(id: UUID().uuidString, name: "Sunnybrook Farm", location: "San Francisco", lastUpdated: "10:00 AM", status: .online, temperature: 21.5, pH: 7.1, humidity: 58.0, soilNutrient: 3.8),
            dummyDevice(id: UUID().uuidString, name: "Greenfield Farm", location: "New York", lastUpdated: "11:30 AM", status: .idle, temperature: 19.2, pH: 6.9, humidity: 65.0, soilNutrient: 3.2),
            dummyDevice(id: UUID().uuidString, name: "Maplewood Farm", location: "Los Angeles", lastUpdated: "12:45 PM", status: .online, temperature: 22.0, pH: 7.0, humidity: 60.0, soilNutrient: 3.5),
            dummyDevice(id: UUID().uuidString, name: "Willow Creek Farm", location: "Chicago", lastUpdated: "09:15 AM", status: .offline, temperature: 20.0, pH: 6.8, humidity: 55.0, soilNutrient: 3.0),
            dummyDevice(id: UUID().uuidString, name: "Oakridge Farm", location: "Seattle", lastUpdated: "08:00 AM", status: .online, temperature: 18.5, pH: 7.2, humidity: 62.0, soilNutrient: 3.9),
            dummyDevice(id: UUID().uuidString, name: "Pine Hill Farm", location: "Austin", lastUpdated: "07:45 AM", status: .offline, temperature: 17.8, pH: 7.3, humidity: 59.0, soilNutrient: 3.4)
        ]
    }

    // Example method to create an array of view models with dummy device data
    func dummyDeviceViewModels() -> [DeviceViewModel] {
        return dummyDevices().map { DeviceViewModel(device: $0) }
    }

    // Generate an array of dummy articles
    func dummyArticles() -> [Article] {
        return [
            dummyArticle(imageName: "article-1", title: "The Future of IoT in Agriculture", content: "The integration of IoT in agriculture has revolutionized the industry by enabling farmers to monitor crops and livestock in real-time. Sensors and connected devices provide valuable data that helps in making informed decisions, improving efficiency, and increasing yields..."),
            dummyArticle(imageName: "article-2", title: "Weather Monitoring in Agriculture", content: "Weather monitoring is crucial in agriculture as it helps farmers make informed decisions about planting, irrigation, and harvesting. Advanced weather stations and IoT devices provide real-time data, ensuring better crop management..."),
            dummyArticle(imageName: "article-3", title: "Effects of Weather Patterns on Crop Growth", content: "Weather patterns significantly impact crop growth. Understanding these patterns helps in predicting yields and planning agricultural activities. Modern technologies assist farmers in adapting to changing weather conditions..."),
            dummyArticle(imageName: "article-4", title: "Onion Farming: Best Practices", content: "Onion farming requires specific practices for optimal growth. From soil preparation to harvesting, understanding the best practices can lead to higher yields and better quality produce. IoT devices aid in monitoring soil conditions and ensuring proper irrigation...")
        ]
    }

    // Generate a single dummy article
    private func dummyArticle(imageName: String, title: String, content: String) -> Article {
        return Article(id: UUID(), imageName: imageName, title: title, content: content)
    }

    // Example method to create an array of view models with dummy article data
    func dummyArticleViewModels() -> [ArticleViewModel] {
        return dummyArticles().map { ArticleViewModel(articles: [$0]) }
    }
}
