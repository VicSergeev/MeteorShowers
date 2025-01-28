//
//  TopView.swift
//  MeteorShowers
//
//  Created by Vic on 26.01.2025.
//

import UIKit
import CoreLocation

final class TopView: UIView {
    
    // MARK: - Properties
    private let moonPhaseCalculator = MoonPhaseCalculation()
    private let sunCalculator = SunRiseSetCalc()
    private let locationManager = LocationManager.shared
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)  // Use UTC to avoid double timezone conversion
        return formatter
    }()

    // MARK: - UIs
    @IBOutlet weak var sunriseTimeLabel: UILabel!
    @IBOutlet weak var sunsetTimeLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var forecastIconImageView: UIImageView!
    
    @IBOutlet weak var moonPhaseIconImageView: UIImageView!
    @IBOutlet weak var IlluminationLabel: UILabel!
    @IBOutlet weak var moonPhaseLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupLocation()
        updateMoonPhase()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 9
        self.layer.masksToBounds = true
        
        // Set initial values
        sunriseTimeLabel.text = "--:--"
        sunsetTimeLabel.text = "--:--"
    }
    
    private func setupLocation() {
        locationManager.delegate = self
        locationManager.requestLocationUpdates()
    }
    
    private func updateMoonPhase() {
        let moonInfo = moonPhaseCalculator.getMoonPhase()
        updateMoonPhaseUI(with: moonInfo)
    }
    
    private func updateMoonPhaseUI(with moonInfo: (phase: String, illumination: Double, age: Double)) {
        moonPhaseLabel.text = moonInfo.phase
        IlluminationLabel.text = String(format: "%.1f%%", moonInfo.illumination)
        
        if let moonPhase = MoonPhase.allCases.first(where: { $0.rawValue == moonInfo.phase }) {
            moonPhaseIconImageView.image = moonPhase.icon
            moonPhaseIconImageView.tintColor = .lightGray
        }
    }
    
    private func updateSunTimes(for location: CLLocation) {
        print("🌅 Calculating sun times for location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
        
        // Get today's date at midnight in current timezone
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        let times = sunCalculator.calculateSunriseSunset(for: today, at: location)
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            if let sunrise = times.sunrise {
                let timeString = self.dateFormatter.string(from: sunrise)
                print("🌅 Sunrise calculated: \(timeString) (Date: \(sunrise))")
                self.sunriseTimeLabel.text = timeString
            } else {
                print("🌅 No sunrise calculated")
                self.sunriseTimeLabel.text = "No sunrise"
            }
            
            if let sunset = times.sunset {
                let timeString = self.dateFormatter.string(from: sunset)
                print("🌅 Sunset calculated: \(timeString) (Date: \(sunset))")
                self.sunsetTimeLabel.text = timeString
            } else {
                print("🌅 No sunset calculated")
                self.sunsetTimeLabel.text = "No sunset"
            }
        }
    }
}

// MARK: - LocationManagerDelegate
extension TopView: LocationManagerDelegate {
    func locationManager(_ manager: LocationManager, didUpdateLocation location: CLLocation) {
        DispatchQueue.main.async { [weak self] in
            self?.updateSunTimes(for: location)
        }
    }
    
    func locationManager(_ manager: LocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async { [weak self] in
            // Use Moscow coordinates as fallback
            let moscowLocation = CLLocation(latitude: 55.7558, longitude: 37.6173)
            self?.updateSunTimes(for: moscowLocation)
        }
    }
}
