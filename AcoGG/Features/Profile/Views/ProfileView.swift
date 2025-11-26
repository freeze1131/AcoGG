//
//  ProfileView.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import SwiftUI

struct ProfileView: View {
    let summonerId: String

    var body: some View {
        VStack(spacing: 20) {
            Text("Profile Page")
                .font(.largeTitle)

            Text("Summoner ID: \(summonerId)")
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Profile")
    }
}

#Preview {
    ProfileView(summonerId: "12345")
}

