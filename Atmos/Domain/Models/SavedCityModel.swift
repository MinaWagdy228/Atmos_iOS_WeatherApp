//
//  SavedCityModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import Foundation

// MARK: - Saved City Domain Model
struct SavedCityModel: Identifiable {
    let id = UUID()
    let name: String
    let temperature: Double
}
