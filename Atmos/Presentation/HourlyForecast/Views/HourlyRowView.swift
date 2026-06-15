//
//  HourlyRowView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import SwiftUI

struct HourlyRowView: View {

    let hour: HourlyModel
    let iconName: String
    @Environment(\.appTheme) private var theme

    var body: some View {
        HStack {
            // Time
            Text(hour.time)
                .font(AppFonts.forecastDay)
                .foregroundStyle(theme.primaryText)
                .frame(width: 56, alignment: .leading)

            Spacer()

            // Icon
            Image(systemName: iconName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 28))
                .frame(width: 36, alignment: .center)

            Spacer()

            // Temperature
            Text("\(Int(hour.temperature))°")
                .font(AppFonts.forecastDay)
                .foregroundStyle(theme.primaryText)
                .frame(width: 48, alignment: .trailing)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
    }
}
