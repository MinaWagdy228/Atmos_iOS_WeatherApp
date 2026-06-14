//
//  WeatherHeaderView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Weather Header View

/// Top "hero" section: city name, large temperature,
/// condition text, H/L row, and the condition icon.
struct WeatherHeaderView: View {

    let viewModel: CurrentWeatherViewModel
    @Environment(\.appTheme) private var theme
    var body: some View {
        VStack(spacing: 2) {

            // City Name
            Text(viewModel.cityName)
                .font(AppFonts.cityName)
                .foregroundStyle(theme.primaryText)

            // Current Temperature
            Text(viewModel.temperature)
                .font(AppFonts.temperature)
                .foregroundStyle(theme.primaryText)

            // Condition Description
            Text(viewModel.condition)
                .font(AppFonts.conditionText)
                .foregroundStyle(theme.primaryText)

            // High / Low
            Text(viewModel.highLow)
                .font(AppFonts.highLow)
                .foregroundStyle(theme.secondaryText)
                .padding(.top, 2)

            // Condition Icon
            Image(systemName: viewModel.systemIconName(for: viewModel.weather.conditionCode))
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 72))
                .shadow(color: .black.opacity(0.12), radius: 6, x: 0, y: 3)
                .padding(.top, 18)
        }
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .day).backgroundGradient.ignoresSafeArea()
        WeatherHeaderView(
            viewModel: DIContainer.shared.makeCurrentWeatherViewModel()
        )
    }
}

