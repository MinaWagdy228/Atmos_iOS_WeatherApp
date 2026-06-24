//
//  WeatherIconMapper.swift
//  Atmos
//
//  Created by Mina_Wagdy on 24/06/2026.
//
import Foundation

enum WeatherIconMapper {
    
    static func systemIconName(for code: Int) -> String {
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
}
