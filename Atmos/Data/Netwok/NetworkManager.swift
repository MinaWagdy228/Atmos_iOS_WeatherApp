//
//  NetworkManager.swift
//  Atmos
//
//  Created by Mina_Wagdy on 14/06/2026.
//

import Foundation

// MARK: - Network Errors
enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingFailed(Error)
    case unknown(Error)
}

// MARK: - Network Manager Protocol
protocol NetworkManager {
    func fetch<T: Decodable>(from url: URL) async throws -> T
}

// MARK: - Network Manager Implementation
final class NetworkManagerImpl: NetworkManager {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(from url: URL) async throws -> T {
        do {
            let (data, response) = try await session.data(from: url)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(URLError(.badServerResponse))
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                throw NetworkError.requestFailed(
                    statusCode: httpResponse.statusCode)
            }

            do {
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingFailed(error)
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
