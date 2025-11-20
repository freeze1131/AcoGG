//
//  NetworkError.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 20.11.2025.
//


import Foundation
// MARK: - Network Error Types
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingError(Error)
    case httpError(statusCode: Int)
    case notFound
    case unauthorized
    case forbidden
    case rateLimited
    case serverError
    case networkUnavailable
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid server response"
        case .decodingError:
            return "Failed to decode response"
        case .httpError(let code):
            return "HTTP Error: \(code)"
        case .notFound:
            return "Summoner not found"
        case .unauthorized:
            return "API key is invalid"
        case .forbidden:
            return "Access forbidden"
        case .rateLimited:
            return "Rate limited. Please wait a moment."
        case .serverError:
            return "Server error. Please try again later."
        case .networkUnavailable:
            return "No internet connection"
        case .unknown:
            return "Something went wrong"
        }
    }
}
