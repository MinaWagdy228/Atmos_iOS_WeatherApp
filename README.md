# Atmos 🌤️

> A premium, glassmorphic iOS weather application demonstrating modern SwiftUI, Clean Architecture, and seamless local persistence.

Atmos is a fully native iOS weather app designed with a focus on fluid animations, dynamic theming, and enterprise-grade architectural patterns. It leverages the latest Apple technologies to deliver real-time weather data, hourly breakdowns, and offline-capable saved location management.

---

## ✨ Key Features

* **Dynamic Glassmorphic UI:** The interface seamlessly transitions between day and night themes based on the local time of the selected city, utilizing a custom SwiftUI `@Environment` injection.
* **Real-Time Data & Forecasts:** View current conditions, a 24-hour breakdown, and a 3-day forecast, formatted with typographic precision (monospaced digits) to prevent UI jitter.
* **Local Persistence:** Save favorite cities to a personalized drawer list. Data is persisted locally using **SwiftData**, completely abstracted behind a Data Layer repository.
* **Offline Resilience:** Built-in network monitoring intercepts requests when offline, safely loading cached data and displaying beautiful, non-intrusive error states.
* **Swipe-to-Delete:** Manage saved locations effortlessly with native iOS swipe gestures and confirmation alerts.
* **Shimmer Loading States:** Skeleton views provide immediate visual feedback while network requests are in flight.

## 🛠️ Tech Stack & Architecture

Atmos is built to scale, adhering strictly to **SOLID** principles and **Clean Architecture**.

* **UI Framework:** SwiftUI
* **Reactivity:** Observation Framework (`@Observable`)
* **Persistence:** SwiftData
* **Architecture:** Clean Architecture + MVVM 
* **Dependency Management:** Centralized `@MainActor` Dependency Injection (DI) Container
* **Concurrency:** Swift Structured Concurrency (`async/await`, `Task`)

### Layer Separation
1. **Domain Layer:** Pure Swift models (`WeatherModel`, `SavedCityModel`) and Use Cases. Zero knowledge of the UI or databases.
2. **Data Layer:** Remote/Local Data Sources, DTOs, and Mappers. SwiftData entities (`SavedCityEntity`) are strictly isolated here.
3. **Presentation Layer:** ViewModels and SwiftUI Views. ViewModels communicate purely through interface protocols.

---

## 🚀 Getting Started

### Prerequisites
* Xcode 15.0+
* iOS 17.0+
* A free API key from [WeatherAPI.com](https://www.weatherapi.com/)

### Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/yourusername/Atmos.git](https://github.com/yourusername/Atmos.git)
   cd Atmos
