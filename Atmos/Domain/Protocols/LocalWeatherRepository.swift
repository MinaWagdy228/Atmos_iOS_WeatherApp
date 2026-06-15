//
//  LocalWeatherRepository.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import Foundation

protocol LocalWeatherRepository {
    func saveCity(name: String, temperature: Double) async throws
    func deleteCity(name: String) async throws
    func getSavedCities() async throws -> [SavedCityModel]
    func isCitySaved(name: String) async throws -> Bool
}
