import SwiftUI

struct SearchView: View {
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // Search Input Section
                VStack(spacing: 12) {
                    // Region Picker
                    Picker("Region", selection: $viewModel.selectedRegion) {
                        Text("North America").tag("na1")
                        Text("Europe West").tag("euw1")
                        Text("Korea").tag("kr")
                        Text("Brazil").tag("br1")
                        Text("LAN").tag("la1")
                        Text("LAS").tag("la2")
                        Text("Russia").tag("ru")
                        Text("Turkey").tag("tr1")
                    }
                    .pickerStyle(.menu)
                    .padding(.horizontal)
                    
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
                        List(viewModel.searchResults) { result in
                            NavigationLink(destination: ProfileView(summonerId: result.summoner.id ?? "")) {
                                HStack(spacing: 12) {
                                    // Profile Icon (circular)
                                    AsyncImage(url: result.summoner.profileIconId.profileIconURL()) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.gray.opacity(0.3), lineWidth: 2))
                                    
                                    // Summoner Info
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(result.riotId)
                                            .font(.headline)
                                        
                                        Text("Level \(result.summoner.summonerLevel)")
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                    
                                    Spacer()
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
