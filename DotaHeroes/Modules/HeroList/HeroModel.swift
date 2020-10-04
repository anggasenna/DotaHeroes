//
//  HeroModel.swift
//  DotaHeroes
//
//  Created by Angga on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import CoreData

struct Hero: Codable {
    let id: Int?
    let localized_name: String?
    let primary_attr: String?
    let attack_type: String?
    let roles: [HeroRole]?
    let img: String?
    let base_health: Int?
    let base_mana: Int?
    let base_attack_max: Int?
    let move_speed: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case localized_name
        case primary_attr
        case attack_type
        case roles
        case img
        case base_health
        case base_mana
        case base_attack_max
        case move_speed
    }
}
