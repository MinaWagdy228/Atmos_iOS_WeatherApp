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

                        // ── The Dynamic Save Button ──────────────────────────
                        Button {
                            viewModel.toggleSaveStatus()
                        } label: {
                            Image(systemName: viewModel.isSaved ? "checkmark.circle.fill" : "plus")
                                // A subtle color change provides excellent UX feedback
                                .foregroundStyle(viewModel.isSaved ? Color.green : theme.primaryText)
                                .font(.system(size: 20, weight: .medium))
                                // Adds a smooth transition when the icon swaps
                                .contentTransition(.symbolEffect(.replace))
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
