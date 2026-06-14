//
//  MetricsGridView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Metrics Grid View

/// Lays out the four weather detail cards (Visibility, Humidity,
/// Feels Like, Pressure) in a 2-column adaptive grid.
struct MetricsGridView: View {

    let viewModel: CurrentWeatherViewModel
    @Environment(\.appTheme) private var theme
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {

            MetricCardView(
                icon:  "eye",
                label: "VISIBILITY",
                value: viewModel.visibility,
                unit:  "km"
            )

            MetricCardView(
                icon:  "drop.fill",
                label: "HUMIDITY",
                value: viewModel.humidity,
                unit:  "%"
            )

            MetricCardView(
                icon:  "thermometer.medium",
                label: "FEELS LIKE",
                value: viewModel.feelsLike,
                unit:  "°"
            )

            MetricCardView(
                icon:  "gauge.medium",
                label: "PRESSURE",
                value: viewModel.pressure,
                unit:  ""
            )
        }
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .day).backgroundGradient.ignoresSafeArea()
        MetricsGridView(
            viewModel: DIContainer.shared.makeCurrentWeatherViewModel())
        .padding()
    }
}

