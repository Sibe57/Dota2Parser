//
//  Hero.swift
//  Dota2Parser
//
//  Created by Федор Еронин on 24.06.2022.
//

import Foundation

struct Hero: Decodable {
    let id: Int
    let localizedName: String
    let primaryAttr: String
    let attackType: String
    let img: String
    let roles: [String]
}

