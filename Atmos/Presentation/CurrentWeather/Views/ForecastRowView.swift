//
//  ForecastRowView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Forecast Row View
struct ForecastRowView: View {

    let day: ForecastDayModel
    let iconName: String
    @Environment(\.appTheme) private var theme

    var body: some View {
        HStack(spacing: 8) {

            // Day Label
            Text(day.dayName)
                .font(AppFonts.forecastDay)
                .foregroundStyle(theme.primaryText)
                .frame(maxWidth: .infinity, alignment: .leading)

            Image(systemName: iconName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 24))
                .frame(width: 30, alignment: .center)

            // Temperature Range
            Text(
                "\(day.lowTemp.formattedTemp)°  –  \(day.highTemp.formattedTemp)°"
            )
            .font(AppFonts.forecastTemp)
            .foregroundStyle(theme.primaryText)
            .monospacedDigit()
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)

    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .night).backgroundGradient.ignoresSafeArea()
        ForecastRowView(
            day: ForecastDayModel.dummyForecast[0],
            iconName: "cloud.sun.fill"
        )
        .padding()
    }
}
