import Observation
//
//  CurrentWeatherViewModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Current Weather ViewModel
/// Using @Observable means SwiftUI automatically tracks property access.
/// We mark it @MainActor to guarantee all UI updates happen on the main thread.
@Observable
@MainActor
final class CurrentWeatherViewModel {

    // MARK: - Dependencies
    // The ViewModel only knows about the Use Case interface, keeping it entirely decoupled from networking logic.
    private let fetchWeatherUseCase: FetchWeatherUseCase

    // MARK: - State Properties
    var weather: WeatherModel = .dummy
    var timeOfDay: TimeOfDay = .current
    var isMenuOpen: Bool = false

    // UI Feedback States
    var isLoading: Bool = false
    var errorMessage: String? = nil

    // MARK: - Initialization
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }

    // MARK: - Intentions (Business Logic)

    func loadWeather(for city: String) async {
        isLoading = true
        errorMessage = nil

        do {
            // Execute the use case
            let fetchedWeather = try await fetchWeatherUseCase.execute(
                for: city)

            // Update the state (this automatically triggers a UI refresh)
            self.weather = fetchedWeather

            // Update the time of day theme based on the current time
            self.timeOfDay = TimeOfDay.current

        } catch {
            // In a production app, you would map this to a user-friendly domain error message
            self.errorMessage =
                "Failed to fetch weather for \(city). Please try again."
            print("Weather Fetch Error: \(error.localizedDescription)")
        }

        isLoading = false
    }

    // MARK: - Formatted Display Values
    // These remain unchanged from your original setup; they cleanly format raw data for the Views.

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

    // MARK: - Private Helpers
    private func formatted(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(value))"
            : String(format: "%.1f", value)
    }
}
