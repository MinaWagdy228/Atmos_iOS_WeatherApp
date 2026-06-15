//
//  DIContainer.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
//
//  DIContainer.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation
import SwiftData

// MARK: - Dependency Injection Container
/// A centralized container that wires up the entire Clean Architecture graph.
/// Marked as @MainActor because it interacts with UI-bound ViewModels and the SwiftData main context.
@MainActor
final class DIContainer {
    
    // MARK: - Singleton
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - SwiftData Infrastructure
    lazy var modelContainer: ModelContainer = {
        do {
            // Initializes the local database for the SavedCityEntity
            return try ModelContainer(for: SavedCityEntity.self)
        } catch {
            fatalError("Could not initialize SwiftData ModelContainer: \(error)")
        }
    }()
    
    // MARK: - Core Infrastructure
    // Assuming you have a base network manager from Phase 1
    lazy var networkManager: NetworkManager = {
        return NetworkManagerImpl()
    }()
    
    // MARK: - Data Sources
    lazy var remoteWeatherDataSource: RemoteWeatherDataSource = {
        return RemoteWeatherDataSourceImpl(networkManager: networkManager)
    }()
    
    lazy var localWeatherDataSource: LocalWeatherDataSource = {
        // Injects the main thread context into the local data source
        return LocalWeatherDataSourceImpl(context: modelContainer.mainContext)
    }()
    
    // MARK: - Repositories
    lazy var weatherRepository: WeatherRepository = {
        return WeatherRepositoryImpl(remoteDataSource: remoteWeatherDataSource)
    }()
    
    lazy var localWeatherRepository: LocalWeatherRepository = {
        return LocalWeatherRepositoryImpl(localDataSource: localWeatherDataSource)
    }()
    
    // MARK: - Use Cases
    lazy var fetchWeatherUseCase: FetchWeatherUseCase = {
        return FetchWeatherUseCaseImpl(repository: weatherRepository)
    }()
    
    // MARK: - ViewModels (Factories)
    /// Creates a fresh instance of the ViewModel, injecting both remote and local dependencies.
    func makeCurrentWeatherViewModel() -> CurrentWeatherViewModel {
        return CurrentWeatherViewModel(
            fetchWeatherUseCase: fetchWeatherUseCase,
            localRepository: localWeatherRepository
        )
    }
}
