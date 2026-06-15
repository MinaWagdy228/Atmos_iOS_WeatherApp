//
//  SearchView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import SwiftUI

struct SearchView: View {

    let theme: AppTheme
    let onDismiss: () -> Void
    let onCitySelected: (WeatherModel) -> Void

    @State private var viewModel = SearchViewModel()
    @FocusState private var isFocused: Bool

    var body: some View {
        ZStack {
            theme.backgroundGradient.ignoresSafeArea()

            VStack(spacing: 0) {

                // ── Search Bar ──────────────────────────────────────────
                    HStack(spacing: 8) {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(theme.secondaryText)

                        TextField("Search city...", text: $viewModel.searchText)
                            .font(AppFonts.forecastDay)
                            .foregroundStyle(theme.primaryText)
                            .tint(theme.primaryText)
                            .focused($isFocused)
                            .autocorrectionDisabled()

                        if !viewModel.searchText.isEmpty {
                            Button {
                                viewModel.searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(theme.secondaryText)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(theme.cardBackground)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(
                                        theme.cardStroke, lineWidth: 0.8)
                            )
                    )
                .padding(.horizontal, 12)
                .padding(.vertical, 10)

                // ── City List ───────────────────────────────────────────
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        ForEach(viewModel.results, id: \.cityName) { city in

                            CityRowView(
                                city: city,
                                iconName: viewModel.systemIconName(
                                    for: city.conditionCode)
                            )
                            .contentShape(Rectangle())
                            .onTapGesture { onCitySelected(city) }

                            if city.cityName != viewModel.results.last?.cityName
                            {
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
                    .padding(.bottom, 32)
                }
            }
        }
        .onAppear { isFocused = true }
    }
}
