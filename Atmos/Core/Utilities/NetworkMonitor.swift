//
//  NetworkMonitor.swift
//  Atmos
//
//  Created by Mina_Wagdy on 15/06/2026.
//
import Foundation
import Network
import Observation

// MARK: - Network Monitor
@Observable
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    var isConnected: Bool = true
    
    private init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
