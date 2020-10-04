//
//  HeroListInteractor.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HeroListInteractor: HeroListPresenterToInteractor {

    var presenter: HeroListInteractorToPresenter?
    var heroes: [Hero] = []
    var filter: [HeroRole] = []
    var filteredHeroes: [Hero] = []
    
    func loadHeroes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let cdHero = NSEntityDescription.entity(forEntityName: "CDHero", in: managedContext)!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDHero")
        
        guard let url = URL(string: "https://api.opendota.com/api/herostats") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            if !result.isEmpty {
                var cdHeroes: [Hero] = []
                for data in result {
                    let hero = Hero(id: data.value(forKey: "id") as? Int,
                                    localized_name: data.value(forKey: "localized_name") as? String,
                                    primary_attr: data.value(forKey: "primary_attr") as? String,
                                    attack_type: data.value(forKey: "attack_type") as? String,
                                    roles: data.value(forKey: "roles") as? [HeroRole],
                                    img: data.value(forKey: "img") as? String,
                                    base_health: data.value(forKey: "base_health") as? Int,
                                    base_mana: data.value(forKey: "base_mana") as? Int,
                                    base_attack_max: data.value(forKey: "base_attack_max") as? Int,
                                    move_speed: data.value(forKey: "move_speed") as? Int)
                    cdHeroes.append(hero)
                }
                heroes = cdHeroes
                presenter?.fetchHeroSuccess(data: heroes)
            }
        } catch {
            print("error")
        }
        
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            let jsonDecoder = JSONDecoder()
            guard let data = data else { return }
            do {
                self?.heroes = try jsonDecoder.decode([Hero].self, from: data)
                let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                do {
                    try managedContext.execute(deleteReq)
                    try managedContext.save()
                } catch {
                    print("delete error")
                }
                if let heroesList = self?.heroes {
                    for hero in heroesList {
                        let newHero = NSManagedObject(entity: cdHero, insertInto: managedContext)
                        newHero.setValue(hero.id, forKey: "id")
                        newHero.setValue(hero.attack_type, forKey: "attack_type")
                        newHero.setValue(hero.base_attack_max, forKey: "base_attack_max")
                        newHero.setValue(hero.base_health, forKey: "base_health")
                        newHero.setValue(hero.base_mana, forKey: "base_mana")
                        newHero.setValue(hero.img, forKey: "img")
                        newHero.setValue(hero.localized_name, forKey: "localized_name")
                        newHero.setValue(hero.move_speed, forKey: "move_speed")
                        newHero.setValue(hero.primary_attr, forKey: "primary_attr")
                        let roles = hero.roles?.map({ $0.rawValue })
                        newHero.setValue(roles, forKey: "roles")
                    }
                    
                    do {
                        try managedContext.save()
                    } catch {
                        print("error")
                    }
                }
                self?.presenter?.fetchHeroSuccess(data: self?.heroes ?? [])
            } catch {
                self?.presenter?.fetchHeroFailed(message: "Failed")
            }
            
        }.resume()
    }
    
    func loadFilter() {
        filter = HeroRole.allCases
        self.presenter?.fetchFilter(data: filter)
    }
    
    func loadFilteredHeroes(with type: HeroRole) {
        if type == .all {
            presenter?.filterHeroesSuccess(data: heroes)
        } else {
            filteredHeroes = heroes.filter({ (hero) -> Bool in
                return (hero.roles?.contains(type)) ?? false
            })
            
            presenter?.filterHeroesSuccess(data: filteredHeroes)
        }
    }
    
    
}
