//
//  HeroModel.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation

struct Hero: Codable {
    let id: Int?
    let name: String?
    let localized_name: String?
    let primary_attr: String?
    let attack_type: String?
    let roles: [HeroRole]?
    let img: String?
    let icon: String?
    let base_health: Int?
    let base_health_regen: Double?
    let base_mana: Int?
    let base_mana_regen: Double?
    let base_armor: Double?
    let base_mr: Int?
    let base_attack_min: Int?
    let base_attack_max: Int?
    let base_str: Int?
    let base_agi: Int?
    let base_int: Int?
    let str_gain: Double?
    let agi_gain: Double?
    let int_gain: Double?
    let attack_range: Int?
    let projectile_speed: Int?
    let attack_rate: Double?
    let move_speed: Int?
    let turn_rate: Double?
    let cm_enabled: Bool?
    let legs: Int?
    let pro_ban: Int?
    let hero_id: Int?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case localized_name
        case primary_attr
        case attack_type
        case roles
        case img
        case icon
        case base_health
        case base_health_regen
        case base_mana
        case base_mana_regen
        case base_armor
        case base_mr
        case base_attack_min
        case base_attack_max
        case base_str
        case base_agi
        case base_int
        case str_gain
        case agi_gain
        case int_gain
        case attack_range
        case projectile_speed
        case attack_rate
        case move_speed
        case turn_rate
        case cm_enabled
        case legs
        case pro_ban
        case hero_id
    }
}
