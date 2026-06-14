//
//  CurrentWeatherView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct CurrentWeatherView: View {

    @StateObject private var viewModel = CurrentWeatherViewModel()

    var body: some View {
        let theme = AppTheme(timeOfDay: viewModel.timeOfDay)

        ZStack(alignment: .leading) {

            // ── Main App Screen ────────────────────────────────────────
            NavigationStack {
                ZStack {
                    theme.backgroundGradient
                        .ignoresSafeArea()

                    VStack(spacing: 0) {
                        TopNavigationBar(theme: theme) {
                            withAnimation(.easeInOut(duration: 0.28)) {
                                viewModel.isMenuOpen = true
                            }
                        }

                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                WeatherHeaderView(viewModel: viewModel, theme: theme)
                                    .padding(.top, 8)
                                ForecastSectionView(viewModel: viewModel, theme: theme)
                                MetricsGridView(viewModel: viewModel, theme: theme)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 36)
                        }
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
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

                SideMenuView(theme: theme) {
                    withAnimation(.easeInOut(duration: 0.28)) {
                        viewModel.isMenuOpen = false
                    }
                }
                .frame(width: drawerWidth)
                .offset(x: viewModel.isMenuOpen ? 0 : -drawerWidth)
            }
        }
        .animation(.easeInOut(duration: 0.28), value: viewModel.isMenuOpen)
    }
}

#Preview {
    CurrentWeatherView()
}
