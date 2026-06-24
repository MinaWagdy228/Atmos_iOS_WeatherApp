//
//  ForecastSectionView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Forecast Section View
struct ForecastSectionView: View {

    let viewModel: CurrentWeatherViewModel
    @Environment(\.appTheme) private var theme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Section Header ──────────────────────────────────────
            Label("3-DAY FORECAST", systemImage: "calendar")
                .font(AppFonts.sectionTitle)
                .foregroundStyle(theme.secondaryText)
                .padding(.horizontal, 16)
                .padding(.top, 14)
                .padding(.bottom, 12)

            sectionDivider

            // ── Forecast Rows ───────────────────────────────────────
            ForEach(viewModel.forecast) { day in
                NavigationLink {
                    HourlyForecastView(day: day)
                } label: {
                    ForecastRowView(
                        day: day,
                        iconName: WeatherIconMapper
                            .systemIconName(for: day.conditionCode)
                    )
                }
                .buttonStyle(.plain)

                if day.id != viewModel.forecast.last?.id {
                    rowDivider
                }
            }
        }
        .background(glassBackground)
    }

    // MARK: Subviews

    private var sectionDivider: some View {
        Rectangle()
            .fill(theme.divider)
            .frame(height: 0.5)
    }

    private var rowDivider: some View {
        Rectangle()
            .fill(theme.divider)
            .frame(height: 0.5)
            .padding(.horizontal, 16)
    }

    private var glassBackground: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(theme.cardBackground)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(theme.cardStroke, lineWidth: 0.8)
            )
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .day).backgroundGradient.ignoresSafeArea()
        ForecastSectionView(
            viewModel: DIContainer.shared.makeCurrentWeatherViewModel()
        )
        .padding()
    }
}
