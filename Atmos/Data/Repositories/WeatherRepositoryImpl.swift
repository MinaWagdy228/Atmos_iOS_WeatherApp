//
//  WeatherRepositoryImpl.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

final class WeatherRepositoryImpl: WeatherRepository {

    private let remoteDataSource: RemoteWeatherDataSource

    init(remoteDataSource: RemoteWeatherDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getWeather(for city: String) async throws -> WeatherModel {
        let dto = try await remoteDataSource.fetchWeather(for: city)

        return mapToDomain(dto: dto)
    }

    // MARK: - Mapping Logic
    private func mapToDomain(dto: WeatherResponseDTO) -> WeatherModel {

        // Map the forecast days
        let forecastModels = dto.forecast.forecastday.enumerated().map {
            index, dayDTO in

            // Map the hours inside each day
            let hourlyModels = dayDTO.hour.map { hourDTO in
                HourlyModel(
                    time: formatHour(hourDTO.time),  // Transforms "2026-06-14 15:00" to "3PM"
                    temperature: hourDTO.tempC,
                    conditionCode: hourDTO.condition.code
                )
            }

            return ForecastDayModel(
                dayName: index == 0 ? "Today" : formatDayName(dayDTO.date),  // Ensures the first day is always "Today"
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

    // MARK: - Date Formatting Helpers
    private func formatDayName(_ dateString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let date = formatter.date(from: dateString) else {
            return dateString
        }

        formatter.dateFormat = "EEE"  // Returns "Wed", "Thu", etc.
        return formatter.string(from: date)
    }

    private func formatHour(_ timeString: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let date = formatter.date(from: timeString) else {
            return timeString
        }

        // Simple logic to display "Now" if the hour matches the current hour
        let currentHour = Calendar.current.component(.hour, from: Date())
        let mappedHour = Calendar.current.component(.hour, from: date)

        if currentHour == mappedHour {
            return "Now"
        }

        formatter.dateFormat = "ha"  // Returns "3PM", "4AM"
        return formatter.string(from: date).replacingOccurrences(
            of: "AM", with: "AM"
        ).replacingOccurrences(of: "PM", with: "PM")
    }
}
