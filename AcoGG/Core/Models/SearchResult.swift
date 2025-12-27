//
//  SearchResult.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 27.12.2025.
//

import Foundation


struct SearchResult: Identifiable {
    let id: String
    let gameName: String
    let tagLine: String
    let summoner: SummonerDTO
    
    var riotId: String {
        "\(gameName)#\(tagLine)"
    }
}
