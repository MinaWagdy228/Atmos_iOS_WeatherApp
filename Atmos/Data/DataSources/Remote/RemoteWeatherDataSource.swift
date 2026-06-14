//
//  WeatherRemoteDataSource.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

protocol RemoteWeatherDataSource {
    func fetchWeather(for query: String) async throws -> WeatherResponseDTO
}

final class RemoteWeatherDataSourceImpl: RemoteWeatherDataSource {
    private let networkManager: NetworkManager

    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    func fetchWeather(for query: String) async throws -> WeatherResponseDTO {
        guard let url = Endpoint.forecast(for: query).url else {
            throw NetworkError.invalidURL
        }

        return try await networkManager.fetch(from: url)
    }
}
