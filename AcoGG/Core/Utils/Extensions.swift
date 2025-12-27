//
//  Extensions.swift
//  AcoGG
//
//  Created by Ahmet Ozen on 27.12.2025.
//

import Foundation


extension Int {
    func profileIconURL(version: String = "14.23.1") -> URL? {
        URL(string: "https://ddragon.leagueoflegends.com/cdn/\(version)/img/profileicon/\(self).png")
    }
}
