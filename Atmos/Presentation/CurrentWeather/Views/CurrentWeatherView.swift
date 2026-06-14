//
//  CurrentWeatherView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct CurrentWeatherView: View {
    
    @State private var viewModel = DIContainer.shared.makeCurrentWeatherViewModel()
    
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
                        
                        // Only show the scroll content if we aren't loading for the first time
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 20) {
                                WeatherHeaderView(viewModel: viewModel, theme: theme)
                                    .padding(.top, 8)
                                
                                ForecastSectionView(viewModel: viewModel, theme: theme)
                                
                                MetricsGridView(viewModel: viewModel, theme: theme)
                            }
                            .padding(.horizontal, 16)
                            .padding(.bottom, 36)
                            .blur(radius: viewModel.isLoading ? 3 : 0)
                        }
                        .refreshable {
                            await viewModel.loadWeather(for: viewModel.cityName)
                        }
                    }
                        
                        // ── State Overlays (Loading & Error) ───────────────────
                        if viewModel.isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                .scaleEffect(1.5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        } else if let errorMessage = viewModel.errorMessage {
                            // Simple error banner
                            VStack {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .font(.largeTitle)
                                    .padding(.bottom, 4)
                                Text(errorMessage)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                
                                Button("Try Again") {
                                    Task { await viewModel.loadWeather(for: "Alexandria") }
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
