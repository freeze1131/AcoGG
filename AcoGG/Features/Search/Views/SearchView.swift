//
//  SearchView.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Search Input Section
                VStack(spacing: 12) {
                    TextField("Enter gameName#tagLine", text: $viewModel.searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                    
                    Button(action: {
                        viewModel.search()
                    }) {
                        Text("Search")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.horizontal)
                    }
                    .disabled(viewModel.searchText.isEmpty)
                }
                .padding(.top)
                
                // Results Section
                VStack {
                    switch viewModel.state {
                    case .idle:
                        VStack(spacing: 12) {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: 48))
                                .foregroundColor(.gray)
                            Text("Search for a summoner")
                                .font(.headline)
                            Text("Format: gameName#tagLine")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                    
                    case .loading:
                        VStack(spacing: 12) {
                            ProgressView()
                            Text("Searching...")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    case .success:
                        List(viewModel.searchResults) { summoner in
                            NavigationLink(destination: ProfileView(summonerId: summoner.id ?? "")) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(summoner.id ?? "Unknown")
                                        .font(.headline)
                                    HStack(spacing: 8) {
                                        Text("Level: \(summoner.summonerLevel)")
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Text(summoner.id ?? "")
                                            .font(.caption2)
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                        .listStyle(.plain)
                    
                    case .error(let message):
                        VStack(spacing: 12) {
                            Image(systemName: "exclamationmark.circle.fill")
                                .font(.system(size: 48))
                                .foregroundColor(.red)
                            Text("Error")
                                .font(.headline)
                            Text(message)
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                viewModel.clearResults()
                            }) {
                                Text("Try Again")
                                    .foregroundColor(.blue)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .multilineTextAlignment(.center)
                        .padding()
                    }
                }
                .frame(maxHeight: .infinity)
                
                Spacer()
            }
            .navigationTitle("Search Summoner")
        }
    }
}

// MARK: - Preview (temporary, will error until you set up environment)
#Preview {
    let mockNetworkService = URLSessionNetworkService(apiKey: "YOUR_API_KEY")
    let viewModel = SearchViewModel(networkService: mockNetworkService)
    SearchView(viewModel: viewModel)
}
