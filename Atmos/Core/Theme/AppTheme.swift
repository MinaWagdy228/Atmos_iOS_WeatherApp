//
//  AppTheme.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Time of Day

enum TimeOfDay {
    case day    // 5:00 AM – 6:00 PM
    case night  // 6:00 PM – 5:00 AM

    static var current: TimeOfDay {
        let hour = Calendar.current.component(.hour, from: Date())
        return (5..<18).contains(hour) ? .day : .night
    }
}

// MARK: - App Theme

struct AppTheme {

    let timeOfDay: TimeOfDay

    // MARK: Text Colors

    var primaryText: Color {
        timeOfDay == .day ? .black : .white
    }

    var secondaryText: Color {
        timeOfDay == .day ? Color.black.opacity(0.65) : Color.white.opacity(0.75)
    }

    var captionText: Color {
        timeOfDay == .day ? Color.black.opacity(0.45) : Color.white.opacity(0.50)
    }

    // MARK: Surface Colors

    var cardBackground: Color {
        timeOfDay == .day ? Color.white.opacity(0.22) : Color.white.opacity(0.08)
    }

    var cardStroke: Color {
        timeOfDay == .day ? Color.white.opacity(0.50) : Color.white.opacity(0.18)
    }

    var divider: Color {
        timeOfDay == .day ? Color.black.opacity(0.08) : Color.white.opacity(0.12)
    }

    // MARK: Background Gradient

    /// Custom multi-stop gradient that evokes a daytime sky (5AM–6PM)
    /// or a deep night sky (6PM–5AM). No image assets required.
    var backgroundGradient: LinearGradient {
        switch timeOfDay {
        case .day:
            return LinearGradient(
                stops: [
                    .init(color: Color(hex: "#3D8BAD"), location: 0.00),
                    .init(color: Color(hex: "#5BAAC6"), location: 0.22),
                    .init(color: Color(hex: "#8BBFCF"), location: 0.50),
                    .init(color: Color(hex: "#C5A97A"), location: 0.76),
                    .init(color: Color(hex: "#B07D45"), location: 1.00)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        case .night:
            return LinearGradient(
                stops: [
                    .init(color: Color(hex: "#07091A"), location: 0.00),
                    .init(color: Color(hex: "#101733"), location: 0.30),
                    .init(color: Color(hex: "#192B52"), location: 0.65),
                    .init(color: Color(hex: "#0F1D3E"), location: 1.00)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }
}

// MARK: - App Fonts

/// Shared type scale used across all screens.
/// Update here to change every occurrence app-wide.
enum AppFonts {
    static let cityName:      Font = .system(size: 34, weight: .semibold)
    static let temperature:   Font = .system(size: 80, weight: .thin)
    static let conditionText: Font = .system(size: 18, weight: .medium)
    static let highLow:       Font = .system(size: 16, weight: .regular)
    static let sectionTitle:  Font = .system(size: 12, weight: .semibold)
    static let forecastDay:   Font = .system(size: 17, weight: .medium)
    static let forecastTemp:  Font = .system(size: 16, weight: .regular)
    static let metricLabel:   Font = .system(size: 12, weight: .semibold)
    static let metricValue:   Font = .system(size: 28, weight: .light)
    static let navTitle:      Font = .system(size: 18, weight: .semibold)
    static let button:        Font = .system(size: 16, weight: .semibold)
}

// MARK: - Color + Hex Init

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:  (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:  (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:  (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default: (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red:     Double(r) / 255,
            green:   Double(g) / 255,
            blue:    Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

