//
//  ChampMasteriesDTO.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import Foundation
// MARK: - ChampionMasteryDTO
/// Represents champion mastery information for a player
/// Response from: getChampionMastery, getTop5ChampionMastery endpoints
struct ChampionMasteryDTO: Codable, Identifiable {
    let puuid: String                          // Player's PUUID (78 characters, encrypted)
    let championId: Int                        // Champion ID
    let championLevel: Int                     // Mastery level (1-7)
    let championPoints: Int                    // Total mastery points for this champion
    let championPointsSinceLastLevel: Int      // Points earned since current level
    let championPointsUntilNextLevel: Int      // Points needed to reach next level (0 if max level)
    let lastPlayTime: Int                      // Last time played (Unix milliseconds)
    let chestGranted: Bool                     // Whether chest earned this season
    let markRequiredForNextLevel: Int          // Mark required for next level
    let championSeasonMilestone: Int           // Current season milestone
    let nextSeasonMilestone: NextSeasonMilestonesDTO?  // Next season milestone info
    let tokensEarned: Int                      // Tokens earned at current level (resets when level advances)
    let milestoneGrades: [String]?             // List of milestone grades
    
    var id: String {
        "\(puuid)-\(championId)"
    }
    
    enum CodingKeys: String, CodingKey {
        case puuid
        case championId
        case championLevel
        case championPoints
        case championPointsSinceLastLevel
        case championPointsUntilNextLevel
        case lastPlayTime
        case chestGranted
        case markRequiredForNextLevel
        case championSeasonMilestone
        case nextSeasonMilestone
        case tokensEarned
        case milestoneGrades
    }
}

// MARK: - NextSeasonMilestonesDTO
/// Contains required next season milestone information
struct NextSeasonMilestonesDTO: Codable {
    let requireGradeCounts: [String: Int]?     // Required grade counts (key-value mapping)
    let rewardMarks: Int                       // Reward marks
    let bonus: Bool                            // Whether bonus
    let rewardConfig: RewardConfigDTO?         // Reward configuration
    
    enum CodingKeys: String, CodingKey {
        case requireGradeCounts
        case rewardMarks
        case bonus
        case rewardConfig
    }
}

// MARK: - RewardConfigDTO
/// Contains reward configuration information
struct RewardConfigDTO: Codable {
    let rewardValue: String                    // Reward value
    let rewardType: String                     // Reward type
    let maximumReward: Int                     // Maximum reward
    
    enum CodingKeys: String, CodingKey {
        case rewardValue
        case rewardType
        case maximumReward
    }
}
