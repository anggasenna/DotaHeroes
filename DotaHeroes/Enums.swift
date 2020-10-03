//
//  Enums.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation

enum HeroType: String {
    case melee = "melee"
    case range = "ranged"
}

enum HeroRole: String, CaseIterable, Codable {
    case carry = "Carry"
    case jungler = "Jungler"
    case disabler = "Disabler"
    case initiator = "Initiator"
    case nuker = "Nuker"
    case support = "Support"
    case durable = "Durable"
    case escape = "Escape"
    case pusher = "Pusher"
    case all = "All"
    
}
