import SwiftUI

struct CityWeatherView: View {

    let weather: WeatherModel
    let onDismiss: () -> Void
    @Environment(\.appTheme) private var theme
    @State private var viewModel: CurrentWeatherViewModel

    init(weather: WeatherModel, onDismiss: @escaping () -> Void) {
        self.weather = weather
        self.onDismiss = onDismiss
        
        let vm = DIContainer.shared.makeCurrentWeatherViewModel()
        vm.weather = weather
        _viewModel = State(initialValue: vm)
    }

    var body: some View {
        NavigationStack {
            ZStack {
                theme.backgroundGradient.ignoresSafeArea()

                VStack(spacing: 0) {
                    HStack {
                        Button(action: onDismiss) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(theme.primaryText)
                        }
                        .frame(width: 44, height: 44)

                        Spacer()
                        Text(viewModel.cityName)
                            .font(AppFonts.navTitle)
                            .foregroundStyle(theme.primaryText)
                        Spacer()

                        Button {
                            // Phase 2: persist city
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 20, weight: .medium))
                                .foregroundStyle(theme.primaryText)
                        }
                        .frame(width: 44, height: 44)
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)

                    // ── Reusable Content Drop-in ────────────────────────
                    WeatherContentView(
                        viewModel: viewModel,
                        isInitialLoading: false
                    )
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .task {
                await viewModel.loadWeather(for: viewModel.cityName)
            }
        }
    }
}
