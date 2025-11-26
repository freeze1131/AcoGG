//
//  SummonerDTO.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import Foundation



struct SummonerDTO: Codable, Identifiable {
    var id: String?
    let profileIconId: Int
    let revisionDate: Int64
    let puuid: String
    let summonerLevel: Int64
    
    var identifier: String {
        puuid
    }
    
    enum CodingKeys: String, CodingKey {
        case profileIconId, revisionDate, puuid, summonerLevel, id
    }
}


