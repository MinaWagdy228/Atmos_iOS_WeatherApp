//
//  TopNavigationBar.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct TopNavigationBar: View {

    @Environment(\.appTheme) private var theme
    let onMenuTap:   () -> Void
    let onSearchTap: () -> Void

    var body: some View {
        HStack {
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(theme.primaryText)
            }
            .frame(width: 44, height: 44)

            Spacer()

            Text("Atmos")
                .font(AppFonts.navTitle)
                .foregroundStyle(theme.primaryText)

            Spacer()

            Button(action: onSearchTap) {
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

#Preview {
    ZStack {
        AppTheme(timeOfDay: .day).backgroundGradient.ignoresSafeArea()
        TopNavigationBar(onMenuTap: {}, onSearchTap: {})
    }
}
