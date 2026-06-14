//
//  FetchWeatherUseCase.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

protocol FetchWeatherUseCase {
    func execute(for city: String) async throws -> WeatherModel
}

final class FetchWeatherUseCaseImpl: FetchWeatherUseCase {

    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(for city: String) async throws -> WeatherModel {
        let cleanedCity = city.trimmingCharacters(
            in: .whitespacesAndNewlines)

        guard !cleanedCity.isEmpty else {
            throw URLError(.badURL)
        }

        return try await repository.getWeather(for: cleanedCity)
    }
}
