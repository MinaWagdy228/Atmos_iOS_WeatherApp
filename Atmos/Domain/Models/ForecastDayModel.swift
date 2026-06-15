//
//  ForecastDayModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

// MARK: - Daily Forecast

struct ForecastDayModel: Identifiable {
    let id = UUID()
    let dayName: String
    let conditionCode: Int
    let conditionText: String
    let lowTemp: Double
    let highTemp: Double
    let hourlyData: [HourlyModel]
}

// MARK: - Hourly Entry

struct HourlyModel: Identifiable {
    let id = UUID()
    let time: String
    let temperature: Double
    let conditionCode: Int
}

// MARK: - Dummy Data

extension ForecastDayModel {
    static let dummyForecast: [ForecastDayModel] = [
        .init(
            dayName: "Today",
            conditionCode: 1006, conditionText: "Cloudy",
            lowTemp: 7.8, highTemp: 15.5,
            hourlyData: HourlyModel.dummy
        ),
        .init(
            dayName: "Wed",
            conditionCode: 1003, conditionText: "Partly Cloudy",
            lowTemp: 6.4, highTemp: 16.1,
            hourlyData: HourlyModel.dummy
        ),
        .init(
            dayName: "Thu",
            conditionCode: 1189, conditionText: "Moderate Rain",
            lowTemp: 8.7, highTemp: 17.8,
            hourlyData: HourlyModel.dummy
        ),
    ]
}

extension HourlyModel {
    static let dummy: [HourlyModel] = [
        .init(time: "Now", temperature: 15, conditionCode: 1003),
        .init(time: "3PM", temperature: 15, conditionCode: 1006),
        .init(time: "4PM", temperature: 14, conditionCode: 1003),
        .init(time: "5PM", temperature: 13, conditionCode: 1006),
        .init(time: "6PM", temperature: 12, conditionCode: 1003),
        .init(time: "7PM", temperature: 11, conditionCode: 1006),
        .init(time: "8PM", temperature: 10, conditionCode: 1000),
    ]
}
