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

    var body: some View {
        let theme = AppTheme(timeOfDay: viewModel.timeOfDay)

        ZStack(alignment: .leading) {

            // ── Main App Screen ────────────────────────────────────────
            NavigationStack {
                ZStack {
                    theme.backgroundGradient
                        .ignoresSafeArea()

                    VStack(spacing: 0) {
                        TopNavigationBar() {
                            withAnimation(.easeInOut(duration: 0.28)) {
                                viewModel.isMenuOpen = true
                            }
                        }
                        // Determine if we are in the initial loading state
                        let isInitialLoading =
                            viewModel.isLoading
                            && viewModel.weather.cityName == "Cairo"

                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                WeatherHeaderView(
                                    viewModel: viewModel
                                )
                                .padding(.top, 8)

                                ForecastSectionView(
                                    viewModel: viewModel)

                                MetricsGridView(
                                    viewModel: viewModel)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 36)

                            //Applying the modifiers based on the loading state
                            .redacted(
                                reason: isInitialLoading ? .placeholder : []
                            )
                            .shimmer(
                                isActive: isInitialLoading,
                                color: theme.shimmerHighlight)
                        }
                        .refreshable {
                            await viewModel.loadWeather(for: viewModel.cityName)
                        }.tint(theme.primaryText)
                    }
                    // ── State Overlays (Error) ───────────────────
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
                // ── The Trigger ────────────────────────────────────────────
                .task {
                    // Fetch the weather as soon as the view appears
                    // Since the Side Menu says "No cities added yet", we load a default.
                    await viewModel.loadWeather(for: "Alexandria")
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

                SideMenuView() {
                    withAnimation(.easeInOut(duration: 0.28)) {
                        viewModel.isMenuOpen = false
                    }
                }
                .frame(width: drawerWidth)
                .offset(x: viewModel.isMenuOpen ? 0 : -drawerWidth)
            }
        }
        .animation(.easeInOut(duration: 0.28), value: viewModel.isMenuOpen)
        .environment(\.appTheme, theme)
    }
}
#Preview {
    CurrentWeatherView()
}
