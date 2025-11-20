//
//  NetworkServiceProtocol.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 20.11.2025.
//

import Foundation

// MARK: - Network Service Protocol
protocol NetworkService {
    /// Fetch data from an endpoint and decode to type T
    /// - Parameter endpoint: The API endpoint to call
    /// - Returns: Decoded response of type T
    /// - Throws: NetworkError on failure
    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T
}
