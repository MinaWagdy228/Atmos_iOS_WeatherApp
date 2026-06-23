//
//  AppTheme+Environment.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//

import SwiftUI

private struct AppThemeKey: EnvironmentKey {  // safe fall back,If a deeply nested view attempts to read the theme before you have explicitly injected it at the top level
    static let defaultValue: AppTheme = AppTheme(timeOfDay: .day)
}

extension EnvironmentValues {
    var appTheme: AppTheme {
        get { self[AppThemeKey.self] }
        set { self[AppThemeKey.self] = newValue }
    }
}
