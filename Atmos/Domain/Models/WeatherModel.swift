//
//  WeatherModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

// MARK: - Weather Model

struct WeatherModel {
    let cityName:      String
    let temperature:   Double
    let condition:     String
    let conditionCode: Int
    let highTemp:      Double
    let lowTemp:       Double
    let visibility:    Double  // km
    let humidity:      Int     // %
    let feelsLike:     Double  // °C
    let pressure:      Double  // hPa
    let forecast:      [ForecastDayModel]
}

// MARK: - Dummy / Preview Data

extension WeatherModel {
    static let dummy = WeatherModel(
        cityName:      "Cairo",
        temperature:   21,
        condition:     "Partly Cloudy",
        conditionCode: 1003,
        highTemp:      16,
        lowTemp:       6,
        visibility:    10,
        humidity:      36,
        feelsLike:     16,
        pressure:      1021,
        forecast:      ForecastDayModel.dummyForecast
    )
}

