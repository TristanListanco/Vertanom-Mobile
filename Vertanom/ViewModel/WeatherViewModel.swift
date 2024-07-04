import Combine
import CoreLocation
import Foundation
import Network

class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherModel?
    @Published var showErrorView: Bool = false

    private var locationManager = LocationManager()
    private var weatherService = WeatherService()
    private var cancellables = Set<AnyCancellable>()
    private var monitor: NWPathMonitor

    init() {
        monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { [weak self] path in
            if path.status == .satisfied {
                self?.checkLocationStatus()
            } else {
                self?.showErrorView = true
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

        locationManager.$location
            .compactMap { $0 }
            .sink { [weak self] location in
                self?.fetchWeather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            .store(in: &cancellables)

        locationManager.$isLocationEnabled
            .sink { [weak self] isEnabled in
                if !isEnabled {
                    self?.showErrorView = true
                }
            }
            .store(in: &cancellables)
    }

    func fetchWeather(latitude: Double, longitude: Double) {
        weatherService.fetchWeather(latitude: latitude, longitude: longitude) { [weak self] weatherModel in
            if let weatherModel = weatherModel {
                self?.weather = weatherModel
                self?.showErrorView = false
            } else {
                self?.showErrorView = true
            }
        }
    }

    private func checkLocationStatus() {
        showErrorView = !locationManager.isLocationEnabled
    }
}
