//
//  HourlyForecastViewModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import Foundation
import Observation

@Observable
final class HourlyForecastViewModel {

    let day: ForecastDayModel

    init(day: ForecastDayModel) {
        self.day = day
    }

    var hours: [HourlyModel] { day.hourlyData }

}
