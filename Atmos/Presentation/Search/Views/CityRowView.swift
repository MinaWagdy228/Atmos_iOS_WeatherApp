//
//  CityRowView.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//

import SwiftUI

struct CityRowView: View {

    let city: WeatherModel
    @Environment(\.appTheme) private var theme
    let iconName: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text(city.cityName)
                    .font(AppFonts.forecastDay)
                    .foregroundStyle(theme.primaryText)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Image(systemName: iconName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 22))
                .frame(width: 30, alignment: .center)

            Text("\(Int(city.temperature))°")
                .font(AppFonts.conditionText)
                .foregroundStyle(theme.primaryText)
                .monospacedDigit()
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
    }
}
