//
//  URLSessionNetworkService.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 20.11.2025.
//

import Foundation

// MARK: - URLSession Network Service Implementation
// MARK: - URLSession Network Service Implementation
class URLSessionNetworkService: NetworkService {
    private let apiKey: String
    private let session: URLSession
    
    init(apiKey: String, session: URLSession = .shared) {
        self.apiKey = apiKey
        self.session = session
    }
    
    func fetch<T: Decodable>(from endpoint: APIEndpoint) async throws -> T {
        // Build URL
        guard var urlComponents = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        // Add query parameters
        if let queryParams = endpoint.queryParameters {
            urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let url = urlComponents.url else {
            throw NetworkError.invalidURL
        }
        
        // Build request
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        // Set headers
        var headers = endpoint.headers ?? [:]
        headers["Authorization"] = "Bearer \(apiKey)"
        request.allHTTPHeaderFields = headers
        
        // Set body if needed
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        // Make request
        do {
            let (data, response) = try await session.data(for: request)
            
            // Handle HTTP response
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            // Check status code
            switch httpResponse.statusCode {
            case 200...299:
                break // Success
            case 400:
                throw NetworkError.invalidResponse
            case 401:
                throw NetworkError.unauthorized
            case 403:
                throw NetworkError.forbidden
            case 404:
                throw NetworkError.notFound
            case 429:
                throw NetworkError.rateLimited
            case 500...599:
                throw NetworkError.serverError
            default:
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }
            
            // Decode response
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
