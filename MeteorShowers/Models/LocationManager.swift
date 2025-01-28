import Foundation
import CoreLocation

protocol LocationManagerDelegate: AnyObject {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation)
    func locationManager(_ manager: LocationManager, didFailWithError error: Error)
}

final class LocationManager: NSObject {
    static let shared = LocationManager()
    private let locationManager = CLLocationManager()
    weak var delegate: LocationManagerDelegate?
    var currentLocation: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationUpdates() {
        print("🌍 Location: Requesting authorization...")
        locationManager.requestWhenInUseAuthorization()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("🌍 Location: Authorization status changed to: \(manager.authorizationStatus.rawValue)")
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            print("🌍 Location: Authorized, starting location updates")
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            print("🌍 Location: Access denied or restricted")
            let error = NSError(domain: "LocationManager",
                              code: 1,
                              userInfo: [NSLocalizedDescriptionKey: "Location access denied"])
            delegate?.locationManager(self, didFailWithError: error)
        case .notDetermined:
            print("🌍 Location: Authorization not determined yet")
            break
        @unknown default:
            print("🌍 Location: Unknown authorization status")
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        
        print("""
        🌍 Location Update Received:
           Latitude: \(location.coordinate.latitude)
           Longitude: \(location.coordinate.longitude)
           Accuracy: \(location.horizontalAccuracy)m
           Timestamp: \(location.timestamp)
        """)
        
        delegate?.locationManager(self, didUpdateLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🌍 Location Error: \(error.localizedDescription)")
        delegate?.locationManager(self, didFailWithError: error)
    }
}
