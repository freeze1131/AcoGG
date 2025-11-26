//
//  MatchDTO.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import Foundation

// MARK: - MatchDTO (Top-level Match Response)
/// Complete match information
/// Response from: getMatchDetails endpoint
struct MatchDTO: Codable, Identifiable {
    let metadata: MetadataDTO
    let info: InfoDTO
    
    var id: String {
        metadata.matchId
    }
    
    enum CodingKeys: String, CodingKey {
        case metadata
        case info
    }
}

// MARK: - MetadataDTO
/// Match metadata containing match ID and participant info
struct MetadataDTO: Codable {
    let dataVersion: String           // API data version
    let matchId: String               // Match ID
    let participants: [String]        // Array of PUUIDs
    
    enum CodingKeys: String, CodingKey {
        case dataVersion
        case matchId
        case participants
    }
}

// MARK: - InfoDTO
/// Detailed match information
struct InfoDTO: Codable {
    let endOfGameResult: String       // "TeamComplete", "Aborted", etc.
    let gameCreation: Int             // Timestamp when game started (milliseconds)
    let gameDuration: Int             // Game duration in seconds
    let gameEndTimestamp: Int         // Timestamp when game ended (milliseconds)
    let gameId: Int                   // Game ID
    let gameMode: String              // CLASSIC, ARAM, etc.
    let gameName: String              // Custom game name (if applicable)
    let gameStartTimestamp: Int       // Timestamp when game started (milliseconds)
    let gameType: String              // MATCHED_GAME, CUSTOM_GAME, etc.
    let gameVersion: String           // Game version (e.g., "14.2.1")
    let mapId: Int                    // Map ID (11 = Summoner's Rift, 12 = ARAM, etc.)
    let platformId: String            // Platform (e.g., "NA1", "EUW1")
    let queueId: Int                  // Queue ID (0 = Custom, 400 = Normal, 420 = Solo/Duo Ranked, 440 = Flex Ranked, etc.)
    let tournamentCode: String?       // Tournament code (if tournament match)
    let participants: [ParticipantDTO]  // Array of 10 participants
    let teams: [TeamDTO]              // Array of 2 teams (Blue and Red)
    
    enum CodingKeys: String, CodingKey {
        case endOfGameResult
        case gameCreation
        case gameDuration
        case gameEndTimestamp
        case gameId
        case gameMode
        case gameName
        case gameStartTimestamp
        case gameType
        case gameVersion
        case mapId
        case platformId
        case queueId
        case tournamentCode
        case participants
        case teams
    }
}

// MARK: - ParticipantDTO
/// Individual player's match statistics
struct ParticipantDTO: Codable, Identifiable {
    let allInPings: Int?
    let assistMePings: Int?
    let assists: Int
    let baitPings: Int?
    let baronKills: Int
    let basicPings: Int?
    let bountyLevel: Int?
    let champExperience: Int
    let champLevel: Int
    let championId: Int              // Champion ID
    let championName: String         // Champion name
    let commandPings: Int?
    let considerableKillContribution: Bool?
    let controlWardsPlaced: Int?
    let damageDealtToBuildings: Int
    let damageDealtToObjectives: Int
    let damageDealtToTurrets: Int
    let damageSelfMitigated: Int
    let dangerPings: Int?
    let deaths: Int
    let detectorWardsPlaced: Int?
    let doubleKills: Int
    let dragonKills: Int
    let enemyMissingPings: Int?
    let enemyVisionPings: Int?
    let firstBloodAssist: Bool
    let firstBloodKill: Bool
    let firstTowerAssist: Bool
    let firstTowerKill: Bool
    let gameEndedInEarlySurrender: Bool
    let gameEndedInSurrender: Bool
    let goldEarned: Int
    let goldSpent: Int
    let holdPings: Int?
    let individualPosition: String?  // TOP, JUNGLE, MIDDLE, BOTTOM, UTILITY
    let inhibitorKills: Int
    let inhibitorTakedowns: Int
    let inhibitorsLost: Int
    let item0: Int
    let item1: Int
    let item2: Int
    let item3: Int
    let item4: Int
    let item5: Int
    let item6: Int
    let itemsPurchased: Int
    let killingSprees: Int
    let kills: Int
    let knockOffCount: Int?
    let largestCriticalStrike: Int
    let largestKillingSpree: Int
    let largestMultiKill: Int
    let longestTimeSpentLiving: Int
    let magicDamageDealt: Int
    let magicDamageDealtToChampions: Int
    let magicDamageTaken: Int
    let missions: [String: Int]?
    let needVisionPings: Int?
    let neutralMinionsKilled: Int
    let nexusKills: Int
    let nexusTakedowns: Int
    let nexusLost: Int
    let objectivesStolen: Int
    let objectivesStolenAssists: Int
    let onMyWayPings: Int?
    let participantId: Int
    let pentaKills: Int
    let perksStats: PerksStatsDTO?
    let physicalDamageDealt: Int
    let physicalDamageDealtToChampions: Int
    let physicalDamageTaken: Int
    let placement: Int?               // TFT placement
    let pushPings: Int?
    let puuid: String
    let quadraKills: Int
    let riotIdGameName: String?
    let riotIdTagline: String?
    let role: String?
    let sightWardsBoughtInGame: Int
    let spell1Casts: Int
    let spell2Casts: Int
    let spell3Casts: Int
    let spell4Casts: Int
    let spellsCast: Int?
    let statPerks: StatPerksDTO?
    let summonerLevel: Int
    let summonerId: String
    let summonerName: String
    let summon1Casts: Int
    let summon1Id: Int               // Summoner spell 1 ID
    let summon2Casts: Int
    let summon2Id: Int               // Summoner spell 2 ID
    let teamEarlySurrendered: Bool
    let teamId: Int                  // 100 = Blue, 200 = Red
    let teamPosition: String?        // TOP, JUNGLE, MIDDLE, BOTTOM, UTILITY
    let timeCCingOthers: Int
    let timePlayed: Int
    let totalDamageDealt: Int
    let totalDamageDealtToChampions: Int
    let totalDamageTaken: Int
    let totalHeal: Int
    let totalHealsOnTeammates: Int
    let totalMinionsKilled: Int
    let totalTimeCCDealt: Int
    let totalUnitsHealed: Int
    let tripleKills: Int
    let trueDamageDealt: Int
    let trueDamageDealtToChampions: Int
    let trueDamageTaken: Int
    let turretKills: Int
    let turretTakedowns: Int
    let turretsLost: Int
    let unrealKills: Int
    let visionScore: Int
    let visionWardsBoughtInGame: Int
    let wardsKilled: Int
    let wardsPlaced: Int
    let win: Bool
    
    var id: String {
        puuid
    }
}

// MARK: - PerksStatsDTO
/// Perk statistics (Runes Reforged)
struct PerksStatsDTO: Codable {
    let goldPerSecond: Int?
    let knockOffCount: Int?
    let damageDealtToObjectives: Int?
    let damageDealtToTurrets: Int?
    let damageDealtToBuildings: Int?
    let itemsFirstBought: [Int]?
    let damageDealtToChampions: Int?
    let damageDealtToTurret: Int?
    
    enum CodingKeys: String, CodingKey {
        case goldPerSecond
        case knockOffCount
        case damageDealtToObjectives
        case damageDealtToTurrets
        case damageDealtToBuildings
        case itemsFirstBought
        case damageDealtToChampions
        case damageDealtToTurret
    }
}

// MARK: - StatPerksDTO
/// Stat perks (Secondary runes like Adaptive Force)
struct StatPerksDTO: Codable {
    let armor: Int?
    let attackSpeed: Int?
    let health: Int?
    let hpRegrowth: Int?
    let abilityHaste: Int?
    let adaptiveForce: Int?
    
    enum CodingKeys: String, CodingKey {
        case armor
        case attackSpeed
        case health
        case hpRegrowth
        case abilityHaste
        case adaptiveForce
    }
}

// MARK: - TeamDTO
/// Team statistics
struct TeamDTO: Codable, Identifiable {
    let teamId: Int                  // 100 = Blue, 200 = Red
    let win: Bool                    // Whether team won
    let bans: [BanDTO]              // Banned champions
    let objectives: ObjectivesDTO   // Objective stats
    
    var id: Int {
        teamId
    }
    
    enum CodingKeys: String, CodingKey {
        case teamId
        case win
        case bans
        case objectives
    }
}

// MARK: - BanDTO
/// Banned champion information
struct BanDTO: Codable, Identifiable {
    let championId: Int
    let pickTurn: Int
    
    var id: Int {
        championId
    }
    
    enum CodingKeys: String, CodingKey {
        case championId
        case pickTurn
    }
}

// MARK: - ObjectivesDTO
/// Team objectives (kills, towers, dragons, etc.)
struct ObjectivesDTO: Codable {
    let baron: ObjectiveDTO
    let champion: ObjectiveDTO
    let dragon: ObjectiveDTO
    let inhibitor: ObjectiveDTO
    let riftHerald: ObjectiveDTO
    let tower: ObjectiveDTO
    
    enum CodingKeys: String, CodingKey {
        case baron
        case champion
        case dragon
        case inhibitor
        case riftHerald = "rift_herald"
        case tower
    }
}

// MARK: - ObjectiveDTO
/// Individual objective stats (kills and takedowns)
struct ObjectiveDTO: Codable {
    let first: Bool                  // Whether team got first
    let kills: Int                   // Total kills of this objective
    
    enum CodingKeys: String, CodingKey {
        case first
        case kills
    }
}
