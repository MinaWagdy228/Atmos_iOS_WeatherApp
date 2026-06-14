//
//  WeatherRepository.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
protocol WeatherRepository {
    func getWeather(for city: String) async throws -> WeatherModel
}
