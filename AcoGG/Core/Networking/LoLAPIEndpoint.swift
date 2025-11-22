//
//  LoLAPIEndpoint.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 20.11.2025.
//

import Foundation

// MARK: - Concrete APIEndpoint Implementation (League of Legends)
enum LoLAPIEndpoint: APIEndpoint {
    
    // Ranked EP
    case getRankedInfo(summonerID: String, region: String)
    
    // Summoner endpoints
    // case searchSummoner(name: String, region: String)
    case getSummonerByPUUID(puuid: String, region: String)
    case getSummonerByID(id: String, region: String)
    
    // Match endpoints
    case getMatchHistory(puuid: String, region: String, queue: Int = 0,start: Int = 0, count: Int = 20)
    case getMatchDetails(matchID: String, region: String)
    
    // Mastery EPs
    case getChampionMastery(summonerID: String, region: String)
    case getTop5ChampionMastery(summonerID: String, region: String, count: Int = 5)
    
    // MARK: APIEndpoint Implementation
    var baseURL: String {
        // Different regions map to regional API endpoints
        switch self {
        case .getRankedInfo(_, let region),
             .getSummonerByPUUID(_, let region),
             .getSummonerByID(_, let region),
             .getMatchHistory(_, let region, _, _, _),
             .getMatchDetails(_, let region),
             .getChampionMastery(_, let region),
             .getTop5ChampionMastery(_, let region, _):
            
            // Map region codes to Riot's regional API endpoints
            let regionalEndpoint: String
            switch region.lowercased() {
            // Americas region
            case "na", "na1", "br", "br1", "la", "la1", "la2":
                regionalEndpoint = "https://americas.api.riotgames.com"
            // Europe region
            case "euw", "euw1", "ru", "tr", "tr1":
                regionalEndpoint = "https://europe.api.riotgames.com"
            // Asia region
            case "kr", "ap", "pbe":
                regionalEndpoint = "https://asia.api.riotgames.com"
            default:
                regionalEndpoint = "https://americas.api.riotgames.com" // default fallback
            }
            return regionalEndpoint
        }
    }
    
    
    var path: String {
        switch self {
        case .getRankedInfo(let puuid, _):
            return "/lol/league/v4/entries/by-puuid/\(puuid)"
        case .getSummonerByPUUID(let puuid, _):
            return "/lol/summoner/v4/summoners/by-puuid/\(puuid)"
        case .getSummonerByID(let summonerId, _):
            return "/lol/summoner/v4/summoners/\(summonerId)"
        case .getMatchHistory(let puuid, _, _, _, _):
            return "/lol/match/v5/matches/by-puuid/\(puuid)/ids"
        case .getMatchDetails(let matchId, _):
            return "/lol/match/v5/matches/\(matchId)"
        case .getChampionMastery(let summonerId, _):
            return "/lol/champion-mastery/v4/champion-masteries/by-puuid/\(summonerId)"
        case .getTop5ChampionMastery(let summonerId, _, _):
            return "/lol/champion-mastery/v4/champion-masteries/by-puuid/\(summonerId)/top"
        }
    }
    
    
    // All EPs are using GET method.
    var method: HTTPMethod {
        return .get
    }
    
    
    var queryParameters: [String : String]? {
        switch self {
        case .getMatchHistory(_, _, let queue, let start, let count):
            return ["queue": String(queue), "start": String(start), "count" : String(count)]
        case .getTop5ChampionMastery(_, _, let count):
            return ["count" : String(count)]
        default:
            return nil
        }
    }
    
    var body: Encodable? {
           nil // GET requests don't have bodies
       }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
        ]
    }
}
