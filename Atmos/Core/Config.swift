//
//  Config.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//

import Foundation

enum Config {

    private enum Keys {
        static let baseURL = "BASE_URL"
        static let apiKey = "API_KEY"
    }

    static var baseURL: String {
        guard
            let urlString = Bundle.main.object(
                forInfoDictionaryKey: Keys.baseURL) as? String
        else {
            fatalError(
                "BASE_URL not found in Info.plist. Check your xcconfig setup.")
        }
        return urlString
    }

    static var apiKey: String {
        guard
            let key = Bundle.main.object(forInfoDictionaryKey: Keys.apiKey)
                as? String
        else {
            fatalError(
                "API_KEY not found in Info.plist. Check your xcconfig setup.")
        }
        return key
    }
}
