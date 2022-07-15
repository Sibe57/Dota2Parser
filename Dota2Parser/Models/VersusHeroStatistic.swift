//
//  VersusHeroStatistic.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 15.07.2022.
//

import Foundation

struct VersusHeroStatistic {
    
    let heroId: Int
    let gamesPlayed: Int
    let wins: Int
    
    var loses: Int { gamesPlayed - wins }
    var winRate: Double { Double(wins) / Double(gamesPlayed) }
    
}
