//
//  CurrentWeatherViewModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation
import Observation
// MARK: - Current Weather ViewModel

@MainActor
@Observable
final class CurrentWeatherViewModel: ObservableObject {

    // MARK: Published State
     var weather:    WeatherModel = .dummy
     var timeOfDay:  TimeOfDay    = .current
     var isMenuOpen: Bool         = false

    // MARK: Formatted Display Values

    var cityName:    String { weather.cityName }
    var temperature: String { "\(Int(weather.temperature))°" }
    var condition:   String { weather.condition }

    var highLow: String {
        "H:\(formatted(weather.highTemp))°  L:\(formatted(weather.lowTemp))°"
    }

    // Raw values — units are handled by the view layer
    var visibility:  String { "\(Int(weather.visibility))" }
    var humidity:    String { "\(weather.humidity)" }
    var feelsLike:   String { "\(Int(weather.feelsLike))" }
    var pressure:    String { "\(Int(weather.pressure))" }

    var forecast: [ForecastDayModel] { weather.forecast }

    // MARK: SF Symbol Resolution

    /// Maps a WeatherAPI condition code to an SF Symbol name.
    /// Real asset icons from Assets.xcassets can replace these later
    /// by swapping the returned string for an asset name.
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

    // MARK: Private Helpers

    private func formatted(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(value))"
            : String(format: "%.1f", value)
    }
}

