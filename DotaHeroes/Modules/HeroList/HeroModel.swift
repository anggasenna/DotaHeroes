//
//  HeroModel.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
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
    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(Int32.self, forKey: .id)
//        localized_name = try values.decode(String.self, forKey: .localized_name)
//        primary_attr = try values.decode(String.self, forKey: .primary_attr)
//        attack_type = try values.decode(String.self, forKey: .attack_type)
//        roles = try values.decode([HeroRole].self, forKey: .roles)
//        img = try values.decode(String.self, forKey: .img)
//        base_health = try values.decode(Int32.self, forKey: .base_health)
//        base_mana = try values.decode(Int32.self, forKey: .base_mana)
//        base_attack_max = try values.decode(Int32.self, forKey: .base_attack_max)
//        move_speed = try values.decode(Int32.self, forKey: .move_speed)
//
//    }
//
//    func encode(to encoder: Encoder) throws {
//
//    }
}

//class CDHero: NSManagedObject {
//
//    @NSManaged var attack_type: String
//    @NSManaged var base_attack_max: Int32
//    @NSManaged var base_health: Int32
//    @NSManaged var base_mana: Int32
//    @NSManaged var id: Int32
//    @NSManaged var img: String
//    @NSManaged var localized_name: String
//    @NSManaged var move_speed: Int32
//    @NSManaged var primary_attr: String
//    @NSManaged var roles: [String]
//
//    var hero: Hero {
//        get {
//           return Hero(id: <#T##Int?#>, localized_name: <#T##String?#>, primary_attr: <#T##String?#>, attack_type: <#T##String?#>, roles: <#T##[HeroRole]?#>, img: <#T##String?#>, base_health: <#T##Int?#>, base_mana: <#T##Int?#>, base_attack_max: <#T##Int?#>, move_speed: <#T##Int?#>)
//        }
//        set {
//            self.id = Int32(newValue.id)
//        }
//    }
//}
