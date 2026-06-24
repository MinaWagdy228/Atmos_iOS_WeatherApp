//
//  MetricCardView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Metric Card View

/// A single glassmorphic card displaying one weather metric.
/// Icon + label sit at the top; the large value (+ optional unit) anchors the bottom.
struct MetricCardView: View {

    let icon:  String
    let label: String
    let value: String
    let unit:  String
    @Environment(\.appTheme) private var theme
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Icon + Label ──────────────────────────────────────
            Label(label, systemImage: icon)
                .font(AppFonts.metricLabel)
                .foregroundStyle(theme.secondaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.85)

            Spacer(minLength: 14)

            // ── Value + Unit ──────────────────────────────────────
            HStack(alignment: .lastTextBaseline, spacing: 2) {
                Text(value)
                    .font(AppFonts.metricValue)
                    .foregroundStyle(theme.primaryText)

                if !unit.isEmpty {
                    Text(unit)
                        .font(AppFonts.highLow)
                        .foregroundStyle(theme.primaryText)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, minHeight: 110, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(theme.cardBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .strokeBorder(theme.cardStroke, lineWidth: 0.8)
                )
        )
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .night).backgroundGradient.ignoresSafeArea()
        HStack(spacing: 12) {
            MetricCardView(icon: "eye", label: "VISIBILITY",
                           value: "10", unit: "km")
            MetricCardView(icon: "drop.fill", label: "HUMIDITY",
                           value: "36", unit: "%")
        }
        .padding()
    }
}

