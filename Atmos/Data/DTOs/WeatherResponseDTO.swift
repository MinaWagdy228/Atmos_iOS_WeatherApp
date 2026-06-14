//
//  WeatherResponseDTO.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import Foundation

struct WeatherResponseDTO: Decodable {
    let location: LocationDTO
    let current: CurrentDTO
    let forecast: ForecastDTO
}

struct LocationDTO: Decodable {
    let name: String
}

struct CurrentDTO: Decodable {
    let tempC: Double
    let condition: ConditionDTO
    let visKm: Double
    let humidity: Int
    let feelslikeC: Double
    let pressureMb: Double
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case condition
        case visKm = "vis_km"
        case humidity
        case feelslikeC = "feelslike_c"
        case pressureMb = "pressure_mb"
    }

}
struct ConditionDTO: Decodable {
    let text: String
    let code: Int
}
struct ForecastDTO: Decodable {
    let forecastday: [ForecastDayDTO]
}
struct ForecastDayDTO: Decodable {
    let date: String
    let day: DayDTO
    let hour: [HourDTO]
}
struct DayDTO: Decodable {
    let maxtempC: Double
    let mintempC: Double
    let condition: ConditionDTO
    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case mintempC = "mintemp_c"
        case condition
    }
}
struct HourDTO: Decodable {
    let time: String
    let tempC: Double
    let condition: ConditionDTO
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case condition
    }
}
