//
//  ForecastSectionView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Forecast Section View

/// Glassmorphic card containing the 3-day forecast header and rows.
/// Each row is a `NavigationLink` so tapping navigates to the hourly view (Phase 2).
struct ForecastSectionView: View {

    let viewModel: CurrentWeatherViewModel
    let theme:     AppTheme

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
                    // HourlyForecastView(day: day)  ← wire up in Phase 2
                    Text("Hourly view coming soon")
                        .foregroundStyle(.white)
                } label: {
                    ForecastRowView(
                        day: day,
                        iconName: viewModel.systemIconName(for: day.conditionCode),
                        theme: theme
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
            viewModel: DIContainer.shared.makeCurrentWeatherViewModel(),
            theme: AppTheme(timeOfDay: .day)
        )
        .padding()
    }
}

