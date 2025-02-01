//
//  NetworkManager.swift
//  MeteorShowers
//
//  Created by Vic on 31.01.2025.
//

import Foundation
import Alamofire
import CoreLocation
import OpenMeteoSdk

enum NetworkError: Error {
    case invalidResponse
    case decodingError
    case apiError(String)
}

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    private let baseURL = "https://api.open-meteo.com/v1/forecast"
    
    func fetchWeather(for location: CLLocation) async throws -> WeatherData {
        let url = URL(string: "\(baseURL)?latitude=\(location.coordinate.latitude)&longitude=\(location.coordinate.longitude)&current=temperature_2m,weather_code&timezone=auto&format=flatbuffers")!
        
        do {
            let responses = try await WeatherApiResponse.fetch(url: url)
            guard let response = responses.first else {
                throw NetworkError.invalidResponse
            }
            
            let current = response.current!
            
            return WeatherData(
                current: .init(
                    temperature: Double(current.variables(at: 0)!.value),
                    weatherCode: Int(current.variables(at: 1)!.value)
                )
            )
        } catch {
            throw NetworkError.apiError(error.localizedDescription)
        }
    }
}
