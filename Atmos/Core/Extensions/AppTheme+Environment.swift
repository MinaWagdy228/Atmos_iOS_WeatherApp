//
//  AppTheme+Environment.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//

import SwiftUI

private struct AppThemeKey: EnvironmentKey {
    static let defaultValue: AppTheme = AppTheme(timeOfDay: .day)
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
