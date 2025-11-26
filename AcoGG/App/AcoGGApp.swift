//
//  AcoGGApp.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 19.11.2025.
//

import SwiftUI

@main
struct AcoGGApp: App {
    let networkService = URLSessionNetworkService(apiKey: "RGAPI-07368356-9561-42ac-8651-3310cf284821")
    
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: SearchViewModel(networkService: networkService))
        }
    }
}
