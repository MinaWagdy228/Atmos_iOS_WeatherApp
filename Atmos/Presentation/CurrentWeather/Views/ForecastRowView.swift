//
//  ForecastRowView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Forecast Row View

/// A single row in the 3-day forecast card.
/// Shows the day label, a multicolor condition icon, and the low–high temp range.
struct ForecastRowView: View {

    let day:      ForecastDayModel
    let iconName: String
    let theme:    AppTheme

    var body: some View {
        HStack(spacing: 8) {

            // Day Label
            Text(day.dayName)
                .font(AppFonts.forecastDay)
                .foregroundStyle(theme.primaryText)
                .frame(width: 56, alignment: .leading)

            Spacer()

            // Condition Icon
            // When asset icons are ready, swap Image(systemName:) for Image(iconName)
            // and remove symbolRenderingMode. Keep the frame to preserve layout.
            Image(systemName: iconName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 24))
                .frame(width: 30, alignment: .center)

            Spacer()

            // Temperature Range
            Text("\(formatted(day.lowTemp))°  –  \(formatted(day.highTemp))°")
                .font(AppFonts.forecastTemp)
                .foregroundStyle(theme.primaryText)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }

    // MARK: Private

    private func formatted(_ value: Double) -> String {
        value.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(value))"
            : String(format: "%.1f", value)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .night).backgroundGradient.ignoresSafeArea()
        ForecastRowView(
            day: ForecastDayModel.dummyForecast[0],
            iconName: "cloud.sun.fill",
            theme: AppTheme(timeOfDay: .night)
        )
        .padding()
    }
}

