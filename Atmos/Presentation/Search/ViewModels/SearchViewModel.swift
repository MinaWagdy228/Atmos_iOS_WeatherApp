//
//  SearchViewModel.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//

import Foundation
import Observation

@Observable
final class SearchViewModel {
    var searchText: String = ""

    var results: [WeatherModel] {
        searchText.trimmingCharacters(in: .whitespaces).isEmpty
            ? WeatherModel.dummyCities
            : WeatherModel.dummyCities.filter {
                $0.cityName.localizedCaseInsensitiveContains(searchText)
            }
    }
    
}
