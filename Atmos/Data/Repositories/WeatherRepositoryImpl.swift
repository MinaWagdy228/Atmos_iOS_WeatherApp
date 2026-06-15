//
//  WeatherRepositoryImpl.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

final class WeatherRepositoryImpl: WeatherRepository {
    
    private let remoteDataSource: RemoteWeatherDataSource
    
    init(remoteDataSource: RemoteWeatherDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getWeather(for city: String) async throws -> WeatherModel {
        let dto = try await remoteDataSource.fetchWeather(for: city)
        
        return WeatherMapper.map(dto: dto)
    }
}
