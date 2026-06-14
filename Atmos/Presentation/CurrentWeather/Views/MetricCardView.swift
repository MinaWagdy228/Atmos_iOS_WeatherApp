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

    let icon:  String   // SF Symbol name — swap for asset name once icons are ready
    let label: String   // Uppercase caption e.g. "VISIBILITY"
    let value: String   // Numeric string e.g. "10"
    let unit:  String   // Unit string e.g. "km", "%" — pass "" to hide
    let theme: AppTheme

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {

            // ── Icon + Label ──────────────────────────────────────
            Label(label, systemImage: icon)
                .font(AppFonts.metricLabel)
                .foregroundStyle(theme.secondaryText)
                .lineLimit(1)
                .minimumScaleFactor(0.85) // we put this when we need to

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
                           value: "10", unit: "km",
                           theme: AppTheme(timeOfDay: .night))
            MetricCardView(icon: "drop.fill", label: "HUMIDITY",
                           value: "36", unit: "%",
                           theme: AppTheme(timeOfDay: .night))
        }
        .padding()
    }
}

