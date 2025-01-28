//
//  MoonPhase.swift
//  MeteorShowers
//
//  Created by Vic on 28.01.2025.
//

import Foundation
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
