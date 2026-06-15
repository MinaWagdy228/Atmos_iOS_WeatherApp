//
//  CurrentWeatherViewModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//

import Observation
import SwiftUI

@Observable
@MainActor
final class CurrentWeatherViewModel {

    // MARK: - Dependencies
    private let fetchWeatherUseCase: FetchWeatherUseCase
    private let localRepository: LocalWeatherRepository

    // MARK: - State
    var weather: WeatherModel = .dummy
    var timeOfDay: TimeOfDay = .current
    var isMenuOpen: Bool = false
    var isSearching: Bool = false

    var isLoading: Bool = false
    var errorMessage: String? = nil

    var isSaved: Bool = false
    let defaultLocation: String = "Alexandria"
    var savedCities: [SavedCityModel] = []


    // MARK: - Init
    init(
        fetchWeatherUseCase: FetchWeatherUseCase,
        localRepository: LocalWeatherRepository
    ) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        self.localRepository = localRepository
        loadSavedCities()
    }

    // MARK: - Network Intentions
    func loadWeather(for city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            weather = try await fetchWeatherUseCase.execute(for: city)
            timeOfDay = .current

            checkIfSaved()

        } catch {
            errorMessage =
                "Failed to fetch weather for \(city). Please try again."
            print("Weather Fetch Error: \(error.localizedDescription)")
        }

        isLoading = false
    }

    // MARK: - Local Data Intentions
    func checkIfSaved() {
        Task {
            do {
                self.isSaved = try await localRepository.isCitySaved(
                    name: weather.cityName)
            } catch {
                print("Failed to check saved status: \(error)")
            }
        }
    }

    func toggleSaveStatus() {
        Task {
            do {
                if isSaved {
                    try await localRepository.deleteCity(name: weather.cityName)
                    self.isSaved = false
                } else {
                    try await localRepository.saveCity(
                        name: weather.cityName, temperature: weather.temperature
                    )
                    self.isSaved = true
                }
            } catch {
                print("Failed to toggle save status: \(error)")
            }
        }
        self.loadSavedCities()
    }
    // MARK: - Drawer & Saved Cities State

    func loadSavedCities() {
        Task {
            do {
                self.savedCities = try await localRepository.getSavedCities()
            } catch {
                print("Failed to load saved cities: \(error)")
            }
        }
    }

    func deleteSavedCity(name: String) {
        Task {
            do {
                try await localRepository.deleteCity(name: name)

                if self.weather.cityName == name {
                    self.isSaved = false
                }

                // Refresh the list immediately
                loadSavedCities()
            } catch {
                print("Failed to delete city: \(error)")
            }
        }
    }

    func selectCityFromDrawer(name: String) async {
        if !NetworkMonitor.shared.isConnected {
            self.errorMessage =
                "No internet connection. Please check your network to load live weather."
            self.isMenuOpen = false
            return
        }

        self.isMenuOpen = false

        try? await Task.sleep(nanoseconds: 250_000_000)

        await loadWeather(for: name)
    }
    func selectCurrentLocationFromDrawer() async {
        if !NetworkMonitor.shared.isConnected {
            self.errorMessage =
                "No internet connection. Please check your network to load live weather."
            self.isMenuOpen = false
            return
        }

        self.isMenuOpen = false
        try? await Task.sleep(nanoseconds: 250_000_000)

        // Always fetches the default home location
        await loadWeather(for: defaultLocation)
    }
    // MARK: - Formatted Display Values
    var cityName: String { weather.cityName }
    var temperature: String { "\(Int(weather.temperature))°" }
    var condition: String { weather.condition }
    var highLow: String {
        "H:\(formatted(weather.highTemp))°  L:\(formatted(weather.lowTemp))°"
    }
    var visibility: String { "\(Int(weather.visibility))" }
    var humidity: String { "\(weather.humidity)" }
    var feelsLike: String { "\(Int(weather.feelsLike))" }
    var pressure: String { "\(Int(weather.pressure))" }
    var forecast: [ForecastDayModel] { weather.forecast }

    // MARK: - SF Symbol Resolution
    func systemIconName(for code: Int) -> String {
        switch code {
        case 1000: return "sun.max.fill"
        case 1003: return "cloud.sun.fill"
        case 1006: return "cloud.fill"
        case 1009: return "smoke.fill"
        case 1030: return "cloud.fog.fill"
        case 1063, 1150...1189: return "cloud.rain.fill"
        case 1066, 1210...1225: return "cloud.snow.fill"
        case 1114: return "wind.snow"
        case 1087, 1273...1282: return "cloud.bolt.rain.fill"
        default: return "cloud.sun.fill"
        }
    }

    // MARK: - Private
    private func formatted(_ v: Double) -> String {
        v.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(v))"
            : String(format: "%.1f", v)
    }
}
