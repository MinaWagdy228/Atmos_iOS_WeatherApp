//
//  SideMenuView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//
import SwiftUI

struct SideMenuView: View {

    @Environment(\.appTheme) private var theme

    let savedCities: [SavedCityModel]
    let onClose: () -> Void
    let onSearchTap: () -> Void
    let onCityTap: (String) -> Void
    let onDelete: (String) -> Void
    let onCurrentLocationTap: () -> Void

    @State private var cityToDelete: String? = nil
    @State private var showDeleteAlert = false

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
                // ── Pinned Current Location Row ────────────────────────
                Button(action: onCurrentLocationTap) {
                    HStack(spacing: 12) {
                        Image(systemName: "location.fill")
                            .font(.system(size: 16))
                        Text("Current Location")
                            .font(.system(size: 16, weight: .medium))
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    // so it stands out from the saved list
                    .background(Color.white.opacity(0.05))
                }
                .buttonStyle(.plain)  // Prevents the whole row from flashing native blue
                .foregroundStyle(theme.primaryText)

                // ── The Dynamic City List ──────────────────────────────
                if savedCities.isEmpty {
                    Text("No cities\nadded yet.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundStyle(theme.secondaryText)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(16)
                } else {
                    List {
                        ForEach(savedCities) { city in
                            Button {
                                onCityTap(city.name)
                            } label: {
                                HStack {
                                    Text(city.name)
                                        .font(
                                            .system(size: 16, weight: .medium))
                                    Spacer()
                                    Text("\(Int(city.temperature))°")
                                        .font(
                                            .system(size: 16, weight: .semibold)
                                        )
                                }
                                .padding(.vertical, 6)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparatorTint(theme.divider)
                            .foregroundStyle(theme.primaryText)

                            // Native Swipe to Delete
                            .swipeActions(
                                edge: .trailing, allowsFullSwipe: false
                            ) {
                                Button(role: .destructive) {
                                    cityToDelete = city.name
                                    showDeleteAlert = true
                                } label: {
                                    Label("Delete", systemImage: "trash")
                                }
                                .tint(.red)
                            }
                        }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)  // Prevents the default iOS gray List background
                }

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
                                    .strokeBorder(
                                        Color.white.opacity(0.40), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 44)
            }
        }
        // ── Delete Confirmation Alert ──────────────────────────────
        .alert("Remove City?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {
                cityToDelete = nil
            }
            Button("Remove", role: .destructive) {
                if let city = cityToDelete {
                    onDelete(city)
                }
            }
        } message: {
            Text(
                "Are you sure you want to remove this city from your saved list?"
            )
        }
    }
}
