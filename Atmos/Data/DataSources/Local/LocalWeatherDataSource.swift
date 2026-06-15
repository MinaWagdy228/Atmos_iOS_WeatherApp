//
//  LocalWeatherDataSource.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//

import Foundation
import SwiftData

// MARK: - Local Data Source Protocol
protocol LocalWeatherDataSource {
    func saveCity(name: String, temperature: Double) async throws
    func deleteCity(name: String) async throws
    func getSavedCities() async throws -> [SavedCityEntity]
    func isCitySaved(name: String) async throws -> Bool
}

// MARK: - Local Data Source Implementation
@MainActor
final class LocalWeatherDataSourceImpl: LocalWeatherDataSource {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func saveCity(name: String, temperature: Double) async throws {
        let newCity = SavedCityEntity(cityName: name, temperature: temperature)
        context.insert(newCity)
        try context.save()
    }
    
    func deleteCity(name: String) async throws {
        let descriptor = FetchDescriptor<SavedCityEntity>(
            predicate: #Predicate { $0.cityName == name }
        )
        if let cityToDelete = try context.fetch(descriptor).first {
            context.delete(cityToDelete)
            try context.save()
        }
    }
    
    func getSavedCities() async throws -> [SavedCityEntity] {
        let descriptor = FetchDescriptor<SavedCityEntity>(
            sortBy: [SortDescriptor(\.savedAt, order: .forward)]
        )
        let savedCities = try context.fetch(descriptor)
        print(savedCities)
        return savedCities
    }
    
    func isCitySaved(name: String) async throws -> Bool {
        let descriptor = FetchDescriptor<SavedCityEntity>(
            predicate: #Predicate { $0.cityName == name }
        )
        let count = try context.fetchCount(descriptor)
        return count > 0
    }
}
