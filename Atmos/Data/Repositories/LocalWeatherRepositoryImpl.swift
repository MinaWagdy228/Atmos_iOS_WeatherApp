//
//  LocalWeatherRepositoryImpl.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//

import Foundation

final class LocalWeatherRepositoryImpl: LocalWeatherRepository {

    private let localDataSource: LocalWeatherDataSource

    init(localDataSource: LocalWeatherDataSource) {
        self.localDataSource = localDataSource
    }

    func saveCity(name: String, temperature: Double) async throws {
        try await localDataSource.saveCity(name: name, temperature: temperature)
    }

    func deleteCity(name: String) async throws {
        try await localDataSource.deleteCity(name: name)
    }

    func getSavedCities() async throws -> [SavedCityModel] {
        let entities = try await localDataSource.getSavedCities()
        // Map the SwiftData entities to our pure Domain Models
        return entities.map {
            SavedCityModel(name: $0.cityName, temperature: $0.temperature)
        }
    }

    func isCitySaved(name: String) async throws -> Bool {
        return try await localDataSource.isCitySaved(name: name)
    }
}
