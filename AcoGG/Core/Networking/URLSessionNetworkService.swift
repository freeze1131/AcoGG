//
//  URLSessionNetworkService.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 20.11.2025.
//

import Foundation

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
        headers["X-Riot-Token"] = apiKey
        request.allHTTPHeaderFields = headers
        
        // Set body if needed
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        // 🔵 Log Request
        logRequest(url: url, method: endpoint.method, headers: headers, body: request.httpBody)
        
        // Make request
        do {
            let (data, response) = try await session.data(for: request)
            
            // 🔵 Log Response
            logResponse(url: url, data: data, response: response)
            
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
            // 🔵 Log Error
            logError(url: url, error: error)
            throw error
        } catch {
            // 🔵 Log Error
            logError(url: url, error: error)
            throw NetworkError.unknown(error)
        }
    }
    
    // MARK: - Logging Helpers
    
    private func logRequest(url: URL, method: HTTPMethod, headers: [String: String], body: Data?) {
        print("\nNetworkManager: 🌐 ===== API REQUEST =====")
        print("NetworkManager: 📍 URL: \(url.absoluteString)")
        print("NetworkManager: 🔧 Method: \(method.rawValue)")
        print("NetworkManager: 📋 Headers:")
        headers.forEach { key, value in
            // Hide sensitive API key (show only first 15 chars)
            if key == "X-Riot-Token" {
                print("NetworkManager:    \(key): \(value.prefix(15))...")
            } else {
                print("NetworkManager:    \(key): \(value)")
            }
        }
        if let body = body, let bodyString = String(data: body, encoding: .utf8) {
            print("NetworkManager: 📦 Body: \(bodyString)")
        }
        print("NetworkManager: ========================\n")
    }
    
    private func logResponse(url: URL, data: Data, response: URLResponse?) {
        print("\nNetworkManager: ✅ ===== API RESPONSE =====")
        print("NetworkManager: 📍 URL: \(url.absoluteString)")
        
        if let httpResponse = response as? HTTPURLResponse {
            let statusEmoji = httpResponse.statusCode >= 200 && httpResponse.statusCode < 300 ? "✅" : "⚠️"
            print("NetworkManager: \(statusEmoji) Status Code: \(httpResponse.statusCode)")
        }
        
        // Pretty print JSON response
        if let jsonString = String(data: data, encoding: .utf8) {
            if let jsonData = jsonString.data(using: .utf8),
               let jsonObject = try? JSONSerialization.jsonObject(with: jsonData),
               let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
               let prettyString = String(data: prettyData, encoding: .utf8) {
                print("NetworkManager: 📄 Response Body:\n\(prettyString)")
            } else {
                print("NetworkManager: 📄 Response Body: \(jsonString)")
            }
        } else {
            print("NetworkManager: 📄 Response: [Binary Data - \(data.count) bytes]")
        }
        
        print("NetworkManager: ===========================\n")
    }
    
    private func logError(url: URL, error: Error) {
        print("\nNetworkManager: ❌ ===== API ERROR =====")
        print("NetworkManager: 📍 URL: \(url.absoluteString)")
        
        if let networkError = error as? NetworkError {
            print("NetworkManager: ⚠️ Error Type: \(networkError)")
            print("NetworkManager: 💬 Description: \(networkError.errorDescription ?? "No description")")
        } else {
            print("NetworkManager: ⚠️ Error: \(error.localizedDescription)")
        }
        
        print("NetworkManager: ========================\n")
    }
}
