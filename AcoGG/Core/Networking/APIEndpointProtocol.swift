//
//  APIEndpointProtocol.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 20.11.2025.
//

import Foundation

// MARK: - API Endpoint Protocol
protocol APIEndpoint {
    /// The base URL for Riot API (region-specific)
    var baseURL: String { get }
    
    /// The path component of the endpoint (e.g., "/lol/summoner/v4/summoners/by-name")
    var path: String { get }
    
    /// HTTP method for this endpoint
    var method: HTTPMethod { get }
    
    /// Query parameters to append to URL
    var queryParameters: [String: String]? { get }
    
    /// Request body for POST/PUT requests
    var body: Encodable? { get }
    
    /// Additional headers (API key, content type, etc.)
    var headers: [String: String]? { get }
}
