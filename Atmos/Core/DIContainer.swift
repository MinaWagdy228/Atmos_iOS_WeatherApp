//
//  DIContainer.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

@MainActor
final class DIContainer {

    static let shared = DIContainer()

    private init() {}
    //MARK: - Network Manager
    lazy var networkManager: NetworkManager = {
        NetworkManagerImpl()
    }()
    // MARK: - Data Sources
    lazy var remoteWeatherDataSource: RemoteWeatherDataSource = {
        RemoteWeatherDataSourceImpl(networkManager: networkManager)
    }()
    // MARK: - Repositories
    lazy var weatherRepository: WeatherRepository = {
        WeatherRepositoryImpl(remoteDataSource: remoteWeatherDataSource)
    }()
    // MARK: - Use Cases
    lazy var fetchWeatherUseCase: FetchWeatherUseCase = {
        FetchWeatherUseCaseImpl(repository: weatherRepository)
    }()
    // MARK: - ViewModels (Factories)
    func makeCurrentWeatherViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(fetchWeatherUseCase: fetchWeatherUseCase)
    }
}
