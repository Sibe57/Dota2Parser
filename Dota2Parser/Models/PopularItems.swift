//
//  PopularItems.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 26.06.2022.
//

import Foundation

struct PopularItems: Decodable {
    let startGameItems: [String: Int]
    let earlyGameItems: [String: Int]
    let midGameItems: [String: Int]
    let lateGameItems: [String: Int]
}
