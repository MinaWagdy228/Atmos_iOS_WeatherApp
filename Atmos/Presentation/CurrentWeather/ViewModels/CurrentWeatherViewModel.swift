import Observation
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

    // MARK: - State
    var weather:     WeatherModel = .dummy
    var timeOfDay:   TimeOfDay    = .current
    var isMenuOpen:  Bool         = false
    var isSearching: Bool         = false

    var isLoading:    Bool    = false
    var errorMessage: String? = nil

    // MARK: - Init
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }

    // MARK: - Intentions
    func loadWeather(for city: String) async {
        isLoading     = true
        errorMessage  = nil

        do {
            weather   = try await fetchWeatherUseCase.execute(for: city)
            timeOfDay = .current
        } catch {
            errorMessage = "Failed to fetch weather for \(city). Please try again."
            print("Weather Fetch Error: \(error.localizedDescription)")
        }

        isLoading = false
    }

    // MARK: - Formatted Display Values
    var cityName:    String { weather.cityName }
    var temperature: String { "\(Int(weather.temperature))°" }
    var condition:   String { weather.condition }
    var highLow:     String { "H:\(formatted(weather.highTemp))°  L:\(formatted(weather.lowTemp))°" }
    var visibility:  String { "\(Int(weather.visibility))" }
    var humidity:    String { "\(weather.humidity)" }
    var feelsLike:   String { "\(Int(weather.feelsLike))" }
    var pressure:    String { "\(Int(weather.pressure))" }
    var forecast:    [ForecastDayModel] { weather.forecast }

    // MARK: - SF Symbol Resolution
    func systemIconName(for code: Int) -> String {
        switch code {
        case 1000:              return "sun.max.fill"
        case 1003:              return "cloud.sun.fill"
        case 1006:              return "cloud.fill"
        case 1009:              return "smoke.fill"
        case 1030:              return "cloud.fog.fill"
        case 1063, 1150...1189: return "cloud.rain.fill"
        case 1066, 1210...1225: return "cloud.snow.fill"
        case 1114:              return "wind.snow"
        case 1087, 1273...1282: return "cloud.bolt.rain.fill"
        default:                return "cloud.sun.fill"
        }
    }

    // MARK: - Private
    private func formatted(_ v: Double) -> String {
        v.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(v))"
            : String(format: "%.1f", v)
    }
}
