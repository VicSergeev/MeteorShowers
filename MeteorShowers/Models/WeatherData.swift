import Foundation

struct WeatherData: Decodable {
    let current: Current
    
    struct Current: Decodable {
        let temperature: Double
        let weatherCode: Int
        
        enum CodingKeys: String, CodingKey {
            case temperature = "temperature_2m"
            case weatherCode = "weather_code"
        }
        
        var condition: WeatherCondition? {
            return WeatherCondition(rawValue: weatherCode)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case current
    }
}
