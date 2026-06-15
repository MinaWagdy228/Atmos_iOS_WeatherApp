//
//  WeatherContentView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import SwiftUI

// MARK: - Shared Weather Layout
struct WeatherContentView: View {
    
    let viewModel: CurrentWeatherViewModel
    let isInitialLoading: Bool
    
    @Environment(\.appTheme) private var theme
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 20) {
                WeatherHeaderView(viewModel: viewModel)
                    .padding(.top, 8)
                ForecastSectionView(viewModel: viewModel)
                MetricsGridView(viewModel: viewModel)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 36)
            
            .redacted(reason: isInitialLoading ? .placeholder : [])
            .shimmer(isActive: isInitialLoading, color: theme.shimmerHighlight)
        }
    }
}
