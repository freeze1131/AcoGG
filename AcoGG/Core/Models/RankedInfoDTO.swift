//
//  RankedInfoDTO.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import Foundation


struct RankedInfoDTO: Codable, Identifiable {
    let leagueId: String
    let puuid: String
    let queueType: String
    let tier: String
    let rank: String
    let leaguePoints: Int
    let wins: Int
    let losses: Int
    let hotStreak: Bool
    let veteran: Bool
    let freshBlood: Bool
    let inactive: Bool
    let miniSeries: MiniSeriesDTO?
    
    var id: String {
        puuid
    }
    
    enum CodingKeys: String, CodingKey {
        case leagueId, puuid, queueType, tier, rank, leaguePoints, wins, losses, hotStreak, veteran, freshBlood, inactive, miniSeries
    }
    
}



struct MiniSeriesDTO: Codable, Identifiable {
    let losses: Int
    let progress: String
    let target: Int
    let wins: Int
    
    var id: String {
        progress
    }
    
    enum CodingKeys: String, CodingKey {
        case losses, progress, target, wins
    }
    
}
