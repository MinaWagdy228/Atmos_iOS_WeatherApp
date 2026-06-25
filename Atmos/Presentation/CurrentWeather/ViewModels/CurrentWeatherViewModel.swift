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
    private let managedSavedCitiesUseCase: ManageSavedCitiesUseCase

    // MARK: - State
    var weather: WeatherModel = .dummy
    var timeOfDay: TimeOfDay = .day
    //    var timeOfDay: TimeOfDay = .current
    var isMenuOpen: Bool = false
    var isSearching: Bool = false

    var isLoading: Bool = false
    var errorMessage: String? = nil

    var isSaved: Bool = false
    var showRemoveConfirmation: Bool = false
    let defaultLocation: String = "Alexandria"
    var savedCities: [SavedCityModel] = []

    // MARK: - Init
    init(
        fetchWeatherUseCase: FetchWeatherUseCase,
        managedSavedCitiesUseCase: ManageSavedCitiesUseCase
    ) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
        self.managedSavedCitiesUseCase = managedSavedCitiesUseCase
        loadSavedCities()
    }

    // MARK: - Network Intentions
    func loadWeather(for city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            weather = try await fetchWeatherUseCase.execute(for: city)
            //timeOfDay = .current
            timeOfDay = weather.isDay == 1 ? .day : .night
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
                self.isSaved = try await managedSavedCitiesUseCase.isCitySaved(
                    name: weather.cityName)
            } catch {
                print("Failed to check saved status: \(error)")
            }
        }
    }
    func handleSaveButtonTapped() {
        if isSaved {
            // Don't delete yet. Tell the UI to ask for confirmation.
            showRemoveConfirmation = true
        } else {
            // Safe to save immediately
            executeSaveCity()
        }
    }
    private func executeSaveCity() {
        Task {
            do {
                try await managedSavedCitiesUseCase.saveCity(
                    name: weather.cityName, temperature: weather.temperature)
                self.isSaved = true
                self.loadSavedCities()
            } catch {
                print("Failed to save city: \(error)")
            }
        }
    }
    func confirmCityRemoval() {
        Task {
            do {
                try await managedSavedCitiesUseCase.deleteCity(
                    name: weather.cityName)
                self.isSaved = false
                self.loadSavedCities()
            } catch {
                print("Failed to delete city: \(error)")
            }
        }
    }
    // MARK: - Drawer & Saved Cities State
    func loadSavedCities() {
        Task {
            do {
                self.savedCities =
                    try await managedSavedCitiesUseCase.getSavedCities()
            } catch {
                print("Failed to load saved cities: \(error)")
            }
        }
    }

    func deleteSavedCity(name: String) {
        Task {
            do {
                try await managedSavedCitiesUseCase.deleteCity(name: name)

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
        "H:\(weather.highTemp.formattedTemp)°  L:\(weather.lowTemp.formattedTemp)°"
    }
    var visibility: String { "\(Int(weather.visibility))" }
    var humidity: String { "\(weather.humidity)" }
    var feelsLike: String { "\(Int(weather.feelsLike))" }
    var pressure: String { "\(Int(weather.pressure))" }
    var forecast: [ForecastDayModel] { weather.forecast }

}
