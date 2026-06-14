//
//  APIEndpoint.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

// MARK: - API Endpoint
struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    
    var url: URL? {
        // We use URLComponents to safely construct the URL piece by piece
        var components = URLComponents(string: Config.baseURL)
        components?.path.append(path)
        components?.queryItems = queryItems
        return components?.url
    }
}

// MARK: - Weather API Endpoints
extension Endpoint {
    
    /// Generates the exact URL for the 3-day forecast
    static func forecast(for city: String) -> Endpoint {
        return Endpoint(
            path: "forecast.json",
            queryItems: [
                URLQueryItem(name: "key", value: Config.apiKey),
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "days", value: "3"),
                URLQueryItem(name: "aqi", value: "no"),
                URLQueryItem(name: "alerts", value: "no")
            ]
        )
    }
}
