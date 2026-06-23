//
//  ManageSavedCitiesUseCase.swift
//  Atmos
//
//  Created by Mina_Wagdy on 23/06/2026.
//
import Foundation

// MARK: - Use Case Protocol
protocol ManageSavedCitiesUseCase {
    func saveCity(name: String, temperature: Double) async throws
    func deleteCity(name: String) async throws
    func getSavedCities() async throws -> [SavedCityModel]
    func isCitySaved(name: String) async throws -> Bool
}

// MARK: - Use Case Implementation
final class ManageSavedCitiesUseCaseImpl: ManageSavedCitiesUseCase {
    
    private let repository: LocalWeatherRepository
    
    init(repository: LocalWeatherRepository) {
        self.repository = repository
    }
    
    func saveCity(name: String, temperature: Double) async throws {
        try await repository.saveCity(name: name, temperature: temperature)
    }
    
    func deleteCity(name: String) async throws {
        try await repository.deleteCity(name: name)
    }
    
    func getSavedCities() async throws -> [SavedCityModel] {
        return try await repository.getSavedCities()
    }
    
    func isCitySaved(name: String) async throws -> Bool {
        return try await repository.isCitySaved(name: name)
    }
}
