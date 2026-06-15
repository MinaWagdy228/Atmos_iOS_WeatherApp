//
//  CurrentWeatherView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct CurrentWeatherView: View {

    @State private var viewModel = DIContainer.shared
        .makeCurrentWeatherViewModel()
    @State private var selectedCity: WeatherModel? = nil
    @State private var showCityDetail = false

    var body: some View {
        let theme = AppTheme(timeOfDay: viewModel.timeOfDay)

        ZStack(alignment: .leading) {

            // ── Main App Screen ────────────────────────────────────────
            NavigationStack {
                ZStack {
                    theme.backgroundGradient.ignoresSafeArea()

                    VStack(spacing: 0) {
                        TopNavigationBar(
                            onMenuTap: {
                                withAnimation(.easeInOut(duration: 0.28)) {
                                    viewModel.loadSavedCities()
                                    viewModel.isMenuOpen = true
                                }
                            },
                            onSearchTap: {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    viewModel.isSearching = true
                                }
                            }
                        )

                        let isInitialLoading =
                            viewModel.isLoading
                            && viewModel.weather.cityName == "Cairo"

                        WeatherContentView(
                            viewModel: viewModel,
                            isInitialLoading: isInitialLoading
                        )
                        .refreshable {
                            await viewModel.loadWeather(for: viewModel.cityName)
                        }
                        .tint(theme.primaryText)
                    }

                    if let errorMessage = viewModel.errorMessage {
                        VStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.largeTitle)
                                .padding(.bottom, 4)
                            Text(errorMessage)
                                .font(.headline)
                                .multilineTextAlignment(.center)
                            Button("Try Again") {
                                Task {
                                    await viewModel.loadWeather(
                                        for: "Alexandria")
                                }
                            }
                            .padding(.top, 8)
                            .buttonStyle(.borderedProminent)
                            .tint(.white.opacity(0.2))
                        }
                        .foregroundStyle(.white)
                        .padding()
                        .background(Color.black.opacity(0.4))
                        .cornerRadius(16)
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
                .task {
                    await viewModel.loadWeather(for: viewModel.defaultLocation)
                }
            }

            // ── Scrim ──────────────────────────────────────────────────
            Color.black
                .opacity(viewModel.isMenuOpen ? 0.45 : 0)
                .ignoresSafeArea()
                .allowsHitTesting(viewModel.isMenuOpen)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.28)) {
                        viewModel.isMenuOpen = false
                    }
                }

            // ── Drawer Panel ───────────────────────────────────────────
            GeometryReader { geo in
                let drawerWidth = geo.size.width / 1.5

                SideMenuView(
                    savedCities: viewModel.savedCities,
                    onClose: {
                        withAnimation(.easeInOut(duration: 0.28)) {
                            viewModel.isMenuOpen = false
                        }
                    },
                    onSearchTap: {
                        withAnimation(.easeInOut(duration: 0.28)) {
                            viewModel.isMenuOpen = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.32) {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                viewModel.isSearching = true
                            }
                        }
                    },
                    onCityTap: { cityName in
                        Task {
                            await viewModel.selectCityFromDrawer(name: cityName)
                        }
                    },
                    onDelete: { cityName in
                        viewModel.deleteSavedCity(name: cityName)
                    },
                    onCurrentLocationTap: {
                        Task {
                            await viewModel.selectCurrentLocationFromDrawer()
                        }
                    }
                )
                .frame(width: drawerWidth)
                .offset(x: viewModel.isMenuOpen ? 0 : -drawerWidth)
            }
            // ── Search Overlay ─────────────────────────────────────────
            if viewModel.isSearching {
                SearchView(
                    theme: theme,
                    onDismiss: {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            viewModel.isSearching = false
                        }
                    },
                    onCitySelected: { city in
                        withAnimation(.easeInOut(duration: 0.25)) {
                            viewModel.isSearching = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            selectedCity = city
                            withAnimation(.easeInOut(duration: 0.32)) {
                                showCityDetail = true
                            }
                        }
                    }
                )
                .transition(.opacity)
                .zIndex(10)
            }

            // ── City Detail Overlay ────────────────────────────────────
            if showCityDetail, let city = selectedCity {
                CityWeatherView(
                    weather: city,
                    onDismiss: {
                        withAnimation(.easeInOut(duration: 0.32)) {
                            showCityDetail = false
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            selectedCity = nil
                        }
                    }
                )
                .transition(.move(edge: .trailing))
                .zIndex(20)
            }
        }
        .animation(.easeInOut(duration: 0.25), value: viewModel.isSearching)
        .animation(.easeInOut(duration: 0.32), value: showCityDetail)
        .environment(\.appTheme, theme)
    }
}

#Preview {
    CurrentWeatherView()
}
