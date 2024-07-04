import Combine
import CoreLocation
import Foundation
import Network

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel?
    @Published var showErrorView: Bool = false

    private var locationManager = LocationManager()
    private var weatherService = WeatherService()
    private var monitor: NWPathMonitor

    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            Task { [weak self] in
                await self?.handleNetworkPathChange(path: path)
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

        Task {
            await setupLocationUpdates()
        }
    }

    func fetchWeather(latitude: Double, longitude: Double) async {
        do {
            if let weatherModel = try await weatherService.fetchWeather(latitude: latitude, longitude: longitude) {
                self.weather = weatherModel
                self.showErrorView = false
            } else {
                self.showErrorView = true
            }
        } catch {
            self.showErrorView = true
        }
    }

    private func handleNetworkPathChange(path: NWPath) async {
        if path.status == .satisfied {
            await checkLocationStatus()
        } else {
            showErrorView = true
        }
    }

    private func setupLocationUpdates() async {
        for await location in locationManager.$location.values {
            guard let location = location else { continue }
            await fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
        
        for await isEnabled in locationManager.$isLocationEnabled.values {
            if !isEnabled {
                showErrorView = true
            }
        }
    }

    private func checkLocationStatus() async {
        showErrorView = !locationManager.isLocationEnabled
    }

    // Public method to request location authorization
    func requestLocationAuthorization() {
        locationManager.requestLocationAuthorization()
    }
}
