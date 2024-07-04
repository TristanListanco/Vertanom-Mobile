import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var isLocationEnabled: Bool = false
    private let locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.delegate = self
        requestLocationAuthorization()
    }

    func requestLocationAuthorization() {
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            handleAuthorizationStatus(status: status)
        }
    }

    private func handleAuthorizationStatus(status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            isLocationEnabled = true
            locationManager.startUpdatingLocation()
        case .denied, .restricted, .notDetermined:
            isLocationEnabled = false
            locationManager.stopUpdatingLocation()
        @unknown default:
            isLocationEnabled = false
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        handleAuthorizationStatus(status: status)
    }
}
