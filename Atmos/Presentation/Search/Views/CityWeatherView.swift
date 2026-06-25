import SwiftUI

struct CityWeatherView: View {

    let weather: WeatherModel
    let onDismiss: () -> Void
    @Environment(\.appTheme) private var theme
    @State private var viewModel = DIContainer.shared
        .makeCurrentWeatherViewModel()
    @State private var showRemoveAlert = false

    init(weather: WeatherModel, onDismiss: @escaping () -> Void) {
        self.weather = weather
        self.onDismiss = onDismiss
    }

    var body: some View {
        @Bindable var bindableViewModel = viewModel
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
                            viewModel.handleSaveButtonTapped()
                        } label: {
                            Image(
                                systemName: viewModel.isSaved
                                    ? "checkmark.circle.fill" : "plus"
                            )
                            // A subtle color change provides excellent UX feedback
                            .foregroundStyle(
                                viewModel.isSaved
                                    ? Color.green : theme.primaryText
                            )
                            .font(.system(size: 20, weight: .medium))
                            // Adds a smooth transition when the icon swaps
                            .contentTransition(.symbolEffect(.replace))
                        }
                        .frame(width: 44, height: 44)
                        .alert(
                            "Remove City",
                            isPresented: $bindableViewModel
                                .showRemoveConfirmation
                        ) {
                            Button("Cancel", role: .cancel) {}

                            Button("Remove", role: .destructive) {
                                viewModel.confirmCityRemoval()
                            }
                        } message: {
                            Text(
                                "Are you sure you want to remove \(viewModel.cityName) from your saved cities?"
                            )
                        }
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
        }.task {
            viewModel.weather = self.weather
        }
    }
}
