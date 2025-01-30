import Foundation

enum WeatherCondition: Int {
    case clearSky = 0
    case mainlyClear = 1
    case partlyCloudy = 2
    case overcast = 3
    case fog = 45
    case depositingRimeFog = 48
    case drizzleLight = 51
    case drizzleModerate = 53
    case drizzleDense = 55
    case freezingDrizzleLight = 56
    case freezingDrizzleDense = 57
    case rainSlight = 61
    case rainModerate = 63
    case rainHeavy = 65
    case freezingRainLight = 66
    case freezingRainHeavy = 67
    case snowSlight = 71
    case snowModerate = 73
    case snowHeavy = 75
    case snowGrains = 77
    case rainShowers = 80
    case rainShowersHeavy = 82
    case snowShowers = 85
    case thunderstorm = 95
    case thunderstormHailSlight = 96
    case thunderstormHailHeavy = 99
    
    var systemIconName: String {
        switch self {
        case .clearSky:
            return "sun.max.fill"
        case .mainlyClear:
            return "sun.max"
        case .partlyCloudy:
            return "cloud.sun.fill"
        case .overcast:
            return "cloud.fill"
        case .fog, .depositingRimeFog:
            return "cloud.fog.fill"
        case .drizzleLight, .drizzleModerate, .drizzleDense:
            return "cloud.drizzle.fill"
        case .freezingDrizzleLight, .freezingDrizzleDense:
            return "cloud.sleet.fill"
        case .rainSlight, .rainModerate:
            return "cloud.rain.fill"
        case .rainHeavy:
            return "cloud.heavyrain.fill"
        case .freezingRainLight, .freezingRainHeavy:
            return "cloud.hail.fill"
        case .snowSlight, .snowModerate:
            return "cloud.snow.fill"
        case .snowHeavy, .snowGrains:
            return "cloud.snow.circle.fill"
        case .rainShowers:
            return "cloud.rain.fill"
        case .rainShowersHeavy:
            return "cloud.heavyrain.fill"
        case .snowShowers:
            return "cloud.snow.fill"
        case .thunderstorm:
            return "cloud.bolt.fill"
        case .thunderstormHailSlight, .thunderstormHailHeavy:
            return "cloud.bolt.rain.fill"
        }
    }
}
