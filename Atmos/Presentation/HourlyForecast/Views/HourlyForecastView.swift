//
//  HourlyForecastView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import SwiftUI

struct HourlyForecastView: View {

    @State private var viewModel: HourlyForecastViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.appTheme) private var theme
    init(day: ForecastDayModel) {
        _viewModel = State(initialValue: HourlyForecastViewModel(day: day))
    }

    var body: some View {
        ZStack {
            theme.backgroundGradient
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Custom Nav Bar ────────────────────────────────────
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(theme.primaryText)
                    }
                    .frame(width: 44, height: 44)

                    Spacer()

                    Text("\(viewModel.day.dayName) Forecast")
                        .font(AppFonts.navTitle)
                        .foregroundStyle(theme.primaryText)

                    Spacer()

                    Color.clear.frame(width: 44, height: 44)  // balance
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)

                // ── Hourly Card ───────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.hours) { hour in
                            HourlyRowView(
                                hour: hour,
                                iconName: WeatherIconMapper
                                    .systemIconName(for: hour.conditionCode)
                            )

                            if hour.id != viewModel.hours.last?.id {
                                Rectangle()
                                    .fill(theme.divider)
                                    .frame(height: 0.5)
                                    .padding(.horizontal, 16)
                            }
                        }
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(theme.cardBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .strokeBorder(
                                        theme.cardStroke, lineWidth: 0.8)
                            )
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 32)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

#Preview {
    NavigationStack {
        HourlyForecastView(day: ForecastDayModel.dummyForecast[0])
    }
}
