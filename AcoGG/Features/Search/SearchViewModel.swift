//
//  SearchViewModel.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import SwiftUI
internal import Combine

// MARK: - Loading State
enum LoadingState {
    case idle
    case loading
    case success
    case error(String)
}

// MARK: - Search View Model
class SearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var searchResults: [SummonerDTO] = []
    @Published var state: LoadingState = .idle
    @Published var errorMessage: String?
    
    private let networkService: NetworkService
    private let region: String = "tr1"
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Search Method
    func search() {
        // 1. Validate input
        let trimmedInput = searchText.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedInput.isEmpty else {
            errorMessage = "Please enter a summoner name"
            state = .error("Please enter a summoner name")
            return
        }
        
        // 2. Validate format (should contain #)
        let components = trimmedInput.split(separator: "#", maxSplits: 1)
        guard components.count == 2 else {
            errorMessage = "Format: gameName#tagLine (e.g., Faker#KR1)"
            state = .error("Format: gameName#tagLine (e.g., Faker#KR1)")
            return
        }
        
        let gameName = String(components[0])
        let tagLine = String(components[1])
        
        // 3. Clear previous results
        searchResults = []
        errorMessage = nil
        
        // 4. Show loading state
        state = .loading
        
        // 5. Make async API call
        Task {
            do {
                // First: Get account info (PUUID) using Riot ID
                let account = try await networkService.fetch(
                    from: LoLAPIEndpoint.searchByRiotID(gameName: gameName, tagLine: tagLine, region: region)
                ) as AccountDTO

                let summoner: SummonerDTO = try await networkService.fetch(
                    from: LoLAPIEndpoint.getSummonerByPUUID(puuid: account.puuid, region: region)
                )
                
                // 6. Success - update on main thread
                await MainActor.run {
                    self.searchResults = [summoner]
                    self.state = .success
                }
                
            } catch {
                // 7. Error - handle it
                let errorMessage = handleError(error)
                await MainActor.run {
                    self.errorMessage = errorMessage
                    self.state = .error(errorMessage)
                }
            }
        }
    }
    
    // MARK: - Clear Results
    func clearResults() {
        searchText = ""
        searchResults = []
        state = .idle
        errorMessage = nil
    }
    
    // MARK: - Error Handler
    private func handleError(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .notFound:
                return "Summoner not found"
            case .unauthorized:
                return "Invalid API key"
            case .rateLimited:
                return "Rate limited. Please wait a moment"
            case .networkUnavailable:
                return "Check your internet connection"
            case .decodingError:
                return "Failed to parse response"
            default:
                return networkError.errorDescription ?? "Unknown error"
            }
        }
        return "Something went wrong"
    }
}
