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
    let isDay:          Int    // 1 or 0
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
        isDay:         1,
        forecast:      ForecastDayModel.dummyForecast
    )
}
extension WeatherModel {
    static let dummyCities: [WeatherModel] = [
        dummy,
        .init(
            cityName: "Dubai", temperature: 38,
            condition: "Sunny", conditionCode: 1000, highTemp: 40, lowTemp: 28,
            visibility: 10, humidity: 45, feelsLike: 41, pressure: 1008,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "London", temperature: 12,
            condition: "Moderate Rain", conditionCode: 1189, highTemp: 14,
            lowTemp: 8, visibility: 6, humidity: 80, feelsLike: 9,
            pressure: 1012,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "New York", temperature: 18,
            condition: "Cloudy", conditionCode: 1006, highTemp: 22, lowTemp: 13,
            visibility: 10, humidity: 55, feelsLike: 17, pressure: 1018,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "Paris", temperature: 16,
            condition: "Partly Cloudy", conditionCode: 1003, highTemp: 19,
            lowTemp: 11, visibility: 10, humidity: 60, feelsLike: 15,
            pressure: 1015,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "Tokyo", temperature: 24,
            condition: "Sunny", conditionCode: 1000, highTemp: 27, lowTemp: 18,
            visibility: 10, humidity: 50, feelsLike: 25, pressure: 1016,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "Sydney", temperature: 22,
            condition: "Clear", conditionCode: 1000, highTemp: 25, lowTemp: 16,
            visibility: 10, humidity: 48, feelsLike: 22, pressure: 1019,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "Berlin", temperature: 10,
            condition: "Overcast", conditionCode: 1009, highTemp: 13,
            lowTemp: 7, visibility: 8, humidity: 70, feelsLike: 8,
            pressure: 1010,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "Toronto", temperature: 8,
            condition: "Light Snow", conditionCode: 1213, highTemp: 10,
            lowTemp: 2, visibility: 5, humidity: 75, feelsLike: 4,
            pressure: 1007,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
        .init(
            cityName: "Istanbul", temperature: 17,
            condition: "Partly Cloudy", conditionCode: 1003, highTemp: 21,
            lowTemp: 12, visibility: 10, humidity: 58, feelsLike: 16,
            pressure: 1013,
            isDay: 1,
            forecast: ForecastDayModel.dummyForecast),
    ]
}
