//
//  Double+Temperature.swift
//  Atmos
//
//  Created by Mina_Wagdy on 24/06/2026.
//
import Foundation

extension Double {
    var formattedTemp: String {
        self.truncatingRemainder(dividingBy: 1) == 0
            ? "\(Int(self))"
            : String(format: "%.1f", self)
    }
}
