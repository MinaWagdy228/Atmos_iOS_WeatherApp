//
//  SavedCityEntity.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import Foundation
import SwiftData

// MARK: - SwiftData Entity
@Model
final class SavedCityEntity {
    
    @Attribute(.unique) var cityName: String
    var temperature: Double
    var savedAt: Date
    
    init(cityName: String, temperature: Double) {
        self.cityName = cityName
        self.temperature = temperature
        self.savedAt = Date()
    }
}
