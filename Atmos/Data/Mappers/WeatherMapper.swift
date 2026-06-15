//
//  WeatherMapper.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import Foundation

// MARK: - Weather Mapper
enum WeatherMapper {

    // MARK: - Main Mapping Function
    static func map(dto: WeatherResponseDTO) -> WeatherModel {

        let currentHour = Calendar.current.component(.hour, from: Date())
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        let forecastModels = dto.forecast.forecastday.enumerated().map {
            index, dayDTO in

            let hourlyModels = dayDTO.hour.compactMap {
                hourDTO -> HourlyModel? in
                if index == 0 {
                    if let hourDate = formatter.date(from: hourDTO.time) {
                        let mappedHour = Calendar.current.component(
                            .hour, from: hourDate)
                        if mappedHour < currentHour { return nil }
                    }
                }

                return HourlyModel(
                    time: formatHour(hourDTO.time),
                    temperature: hourDTO.tempC,
                    conditionCode: hourDTO.condition.code
                )
            }

            return ForecastDayModel(
                dayName: index == 0 ? "Today" : formatDayName(dayDTO.date),
                conditionCode: dayDTO.day.condition.code,
                conditionText: dayDTO.day.condition.text,
                lowTemp: dayDTO.day.mintempC,
                highTemp: dayDTO.day.maxtempC,
                hourlyData: hourlyModels
            )
        }

        return WeatherModel(
            cityName: dto.location.name,
            temperature: dto.current.tempC,
            condition: dto.current.condition.text,
            conditionCode: dto.current.condition.code,
            highTemp: forecastModels.first?.highTemp ?? 0,
            lowTemp: forecastModels.first?.lowTemp ?? 0,
            visibility: dto.current.visKm,
            humidity: dto.current.humidity,
            feelsLike: dto.current.feelslikeC,
            pressure: dto.current.pressureMb,
            forecast: forecastModels
        )
    }

    // MARK: - Private Date Formatters
    private static func formatDayName(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else {
            return dateString
        }

        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }

    private static func formatHour(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else {
            return timeString
        }

        let currentHour = Calendar.current.component(.hour, from: Date())
        let mappedHour = Calendar.current.component(.hour, from: date)

        if currentHour == mappedHour { return "Now" }

        formatter.dateFormat = "ha"
        return formatter.string(from: date).replacingOccurrences(
            of: "AM", with: "AM"
        ).replacingOccurrences(of: "PM", with: "PM")
    }
}
