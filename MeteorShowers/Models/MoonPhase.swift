//
//  MoonPhase.swift
//  MeteorShowers
//
//  Created by Vic on 28.01.2025.
//

import Foundation

struct MoonPhaseCalculation {

    func getMoonPhase(date: Date) -> (phase: String, illumination: Double, age: Double) {
        let synodicMonth: Double = 29.53058867 // average duration of synodic month
        let knownNewMoon: Date = {
            // closest known new moon date (UTC)
            var components = DateComponents()
            components.year = 2000
            components.month = 1
            components.day = 6
            components.hour = 18
            components.minute = 14
            components.second = 0
            return Calendar(identifier: .gregorian).date(from: components)!
        }()
        
        let elapsedTime = date.timeIntervalSince(knownNewMoon) / 86400.0 // convert into days count
        let moonAge = elapsedTime.truncatingRemainder(dividingBy: synodicMonth) // moon age
        let normalizedAge = moonAge < 0 ? moonAge + synodicMonth : moonAge
        
        let illumination = (1 - cos(2 * .pi * normalizedAge / synodicMonth)) / 2
        
        let phase: String
        switch normalizedAge {
        case 0..<1:
            phase = "New Moon"
        case 1..<7.4:
            phase = "Waxing Crescent"
        case 7.4..<8.9:
            phase = "First Quarter"
        case 8.9..<14.8:
            phase = "Waxing Gibbous"
        case 14.8..<15.9:
            phase = "Full Moon"
        case 15.9..<22.1:
            phase = "Waning Gibbous"
        case 22.1..<23.7:
            phase = "Last Quarter"
        default:
            phase = "Waning Crescent"
        }
        
        return (phase: phase, illumination: illumination * 100, age: normalizedAge)
    }

}
