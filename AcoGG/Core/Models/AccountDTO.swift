//
//  AccountDTO.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 26.11.2025.
//

import Foundation


struct AccountDTO: Codable, Identifiable {
    let puuid: String
    let gameName: String
    let tagLine: String
    
    var id: String {
        puuid
    }
    
    
    enum CodingKeys: String, CodingKey {
        case puuid, gameName, tagLine
    }
}
