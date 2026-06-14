//
//  TopNavigationBar.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

// MARK: - Top Navigation Bar

/// Reusable custom nav bar used across all screens.
/// Pass the correct `theme` and action closures for each screen's needs.
struct TopNavigationBar: View {

    let theme:     AppTheme
    let onMenuTap: () -> Void

    var body: some View {
        HStack {
            // ── Hamburger / Menu ──────────────────────────────────────
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(theme.primaryText)
            }
            .frame(width: 44, height: 44)

            Spacer()

            // ── App Name ──────────────────────────────────────────────
            Text("Atmos")
                .font(AppFonts.navTitle)
                .foregroundStyle(theme.primaryText)

            Spacer()

            // ── Search ────────────────────────────────────────────────
            Button(action: {
                // Phase 2: Navigate to SearchView
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(theme.primaryText)
            }
            .frame(width: 44, height: 44)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
    }
}

// MARK: - Preview

#Preview {
    ZStack {
        AppTheme(timeOfDay: .day).backgroundGradient.ignoresSafeArea()
        TopNavigationBar(theme: AppTheme(timeOfDay: .day)) {}
    }
}

