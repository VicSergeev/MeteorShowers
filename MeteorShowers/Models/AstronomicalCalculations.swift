//
//  MoonPhase.swift
//  MeteorShowers
//
//  Created by Vic on 28.01.2025.
//

import Foundation
import CoreLocation
import UIKit

enum MoonPhase: String, CaseIterable {
    case newMoon = "New Moon"
    case waxingCrescent = "Waxing Crescent"
    case firstQuarter = "First Quarter"
    case waxingGibbous = "Waxing Gibbous"
    case fullMoon = "Full Moon"
    case waningGibbous = "Waning Gibbous"
    case lastQuarter = "Last Quarter"
    case waningCrescent = "Waning Crescent"
    
    // method gets icon from SF Symbols
    var iconName: String {
        switch self {
        case .newMoon: return "moonphase.new.moon"
        case .waxingCrescent: return "moonphase.waxing.crescent"
        case .firstQuarter: return "moonphase.first.quarter"
        case .waxingGibbous: return "moonphase.waxing.gibbous"
        case .fullMoon: return "moonphase.full.moon"
        case .waningGibbous: return "moonphase.waning.gibbous"
        case .lastQuarter: return "moonphase.last.quarter"
        case .waningCrescent: return "moonphase.waning.crescent"
        }
    }
    
    // method getting icon and convert it to UIImage
    var icon: UIImage? {
        return UIImage(systemName: self.iconName)
    }
}

struct MoonPhaseCalculation {
    // Known new moon date for better accuracy
    private let knownNewMoon: Date = {
        var components = DateComponents()
        components.year = 2024
        components.month = 12
        components.day = 31
        components.hour = 3
        components.minute = 27
        components.second = 0
        return Calendar(identifier: .gregorian).date(from: components)!
    }()
    
    private let synodicMonth: Double = 29.53058867 // average duration of synodic month
    
    func getMoonPhase(date: Date = Date()) -> (phase: String, illumination: Double, age: Double) {
        let elapsedTime = date.timeIntervalSince(knownNewMoon) / 86400.0 // convert to days
        let moonAge = elapsedTime.truncatingRemainder(dividingBy: synodicMonth)
        let normalizedAge = moonAge < 0 ? moonAge + synodicMonth : moonAge
        
        // Calculate illumination using the normalized age
        let angleInRadians = 2 * .pi * normalizedAge / synodicMonth
        let illumination = ((1 - cos(angleInRadians)) / 2) * 100
        
        let phase: String
        switch normalizedAge {
        case 0..<1.84:
            phase = MoonPhase.newMoon.rawValue
        case 1.84..<5.53:
            phase = MoonPhase.waxingCrescent.rawValue
        case 5.53..<9.22:
            phase = MoonPhase.firstQuarter.rawValue
        case 9.22..<12.91:
            phase = MoonPhase.waxingGibbous.rawValue
        case 12.91..<16.61:
            phase = MoonPhase.fullMoon.rawValue
        case 16.61..<20.30:
            phase = MoonPhase.waningGibbous.rawValue
        case 20.30..<23.99:
            phase = MoonPhase.lastQuarter.rawValue
        default:
            phase = MoonPhase.waningCrescent.rawValue
        }
        
        return (phase: phase, illumination: illumination, age: normalizedAge)
    }
}

struct SunRiseSetCalc {
    func calculateSunriseSunset(for date: Date = Date(), at location: CLLocation) -> (sunrise: Date?, sunset: Date?) {
        // Get the start of day in local timezone
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        
        // Constants
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        let dayOfYear = calendar.ordinality(of: .day, in: .year, for: date) ?? 1
        
        // Calculate solar declination
        let gamma = 2.0 * .pi / 365.0 * Double(dayOfYear - 1)
        let declination = 0.006918 - 0.399912 * cos(gamma) + 0.070257 * sin(gamma) - 0.006758 * cos(2 * gamma) + 0.000907 * sin(2 * gamma) - 0.002697 * cos(3 * gamma) + 0.00148 * sin(3 * gamma)
        
        // Calculate time offset
        let eqTime = 229.18 * (0.000075 + 0.001868 * cos(gamma) - 0.032077 * sin(gamma) - 0.014615 * cos(2 * gamma) - 0.040849 * sin(2 * gamma))
        
        // Calculate solar noon (in minutes from midnight UTC)
        let solarNoon = (720 - 4.0 * longitude - eqTime) / 1440.0 * 24.0  // Convert to hours
        
        // Calculate hour angle
        let ha = acos(cos(90.833 * .pi / 180) / (cos(latitude * .pi / 180) * cos(declination)) - tan(latitude * .pi / 180) * tan(declination))
        let haHours = ha * 180.0 / .pi / 15.0
        
        // Calculate sunrise and sunset times (in hours UTC)
        let sunriseHour = (solarNoon - haHours)
        let sunsetHour = (solarNoon + haHours)
        
        // Convert hours to date components
        var riseComponents = calendar.dateComponents([.year, .month, .day], from: startOfDay)
        riseComponents.hour = Int(floor(sunriseHour))
        riseComponents.minute = Int((sunriseHour.truncatingRemainder(dividingBy: 1.0) * 60.0).rounded())
        
        var setComponents = calendar.dateComponents([.year, .month, .day], from: startOfDay)
        setComponents.hour = Int(floor(sunsetHour))
        setComponents.minute = Int((sunsetHour.truncatingRemainder(dividingBy: 1.0) * 60.0).rounded())
        
        // Create UTC dates
        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.timeZone = TimeZone(secondsFromGMT: 0)!
        
        guard let sunriseUTC = utcCalendar.date(from: riseComponents),
              let sunsetUTC = utcCalendar.date(from: setComponents) else {
            return (nil, nil)
        }
        
        // Convert to local time
        let localSunrise = calendar.date(byAdding: .second, value: TimeZone.current.secondsFromGMT(), to: sunriseUTC)
        let localSunset = calendar.date(byAdding: .second, value: TimeZone.current.secondsFromGMT(), to: sunsetUTC)
        
        print("""
        🌅 Debug Sun Calculation:
           Location: \(latitude)°N, \(longitude)°E
           Day of Year: \(dayOfYear)
           Solar Declination: \(declination * 180.0 / .pi)°
           Equation of Time: \(eqTime) minutes
           Solar Noon (UTC): \(solarNoon) hours
           Hour Angle: \(haHours) hours
           Sunrise Hour (UTC): \(sunriseHour) hours
           Sunset Hour (UTC): \(sunsetHour) hours
           Local Timezone Offset: \(TimeZone.current.secondsFromGMT()/3600) hours
           Final Local Sunrise: \(localSunrise ?? Date())
           Final Local Sunset: \(localSunset ?? Date())
        """)
        
        return (sunrise: localSunrise, sunset: localSunset)
    }
}
