//
//  SideMenuView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct SideMenuView: View {

    @Environment(\.appTheme) private var theme
    let onClose:     () -> Void
    let onSearchTap: () -> Void

    var body: some View {
        ZStack(alignment: .topLeading) {
            theme.backgroundGradient.ignoresSafeArea()

            VStack(alignment: .leading, spacing: 0) {
                Text("Atmos")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(theme.primaryText)
                    .padding(.horizontal, 16)
                    .padding(.top, 64)
                    .padding(.bottom, 4)

                Text("LOCATIONS")
                    .font(AppFonts.sectionTitle)
                    .foregroundStyle(theme.captionText)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 16)

                Rectangle()
                    .fill(theme.divider)
                    .frame(height: 0.5)

                Text("No cities\nadded yet.")
                    .font(.system(size: 13, weight: .regular))
                    .foregroundStyle(theme.secondaryText)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(16)

                Spacer()

                // ── Add City Button ──────────────────────────────────
                Button(action: onSearchTap) { 
                    VStack(spacing: 6) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 22, weight: .semibold))
                        Text("Add City")
                            .font(.system(size: 11, weight: .semibold))
                            .lineLimit(1)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 14)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.18))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.white.opacity(0.40), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 44)
            }
        }
    }
}

#Preview("Day") {
    SideMenuView(onClose: {}, onSearchTap: {})
        .frame(width: 130)
}

#Preview("Night") {
    SideMenuView(onClose: {}, onSearchTap: {})
        .frame(width: 130)
}
