//
//  HeroDetailInteractor.swift
//  DotaHeroes
//
//  Created by BRI on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class HeroDetailInteractor: HeroDetailPresenterToInteractor {
    
    var presenter: HeroDetailInteractorToPresenter?
    
    func loadSimilarHeroes(with data: Hero?) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CDHero")
        fetchRequest.predicate = NSPredicate(format: "primary_attr == %@ AND id != %i", data?.primary_attr ?? "", data?.id ?? 0)
        let agi = NSSortDescriptor(key: "move_speed", ascending: false)
        let str = NSSortDescriptor(key: "base_attack_max", ascending: false)
        let int = NSSortDescriptor(key: "base_mana", ascending: false)
        switch data?.primary_attr {
        case "agi": fetchRequest.sortDescriptors = [agi]
        case "str": fetchRequest.sortDescriptors = [str]
        case "int":  fetchRequest.sortDescriptors = [int]
        default: break
        }
        
        var heroes: [Hero] = []
        
        do {
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for object in 0...2 {
                let data = result[object]
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
                heroes.append(hero)
            }
            presenter?.fetchSimilarHeroSuccess(data: heroes)
        } catch {
            print("error")
        }
    }
    
    func loadHeroImage(url: String?) {
        let home = NSURL(string: "https://api.opendota.com")
        guard let fullUrl = URL(string: url ?? "", relativeTo: home as URL?) else { return }
        let cachedImage = NSCache<NSURL, UIImage>()
        
        if let image = cachedImage.object(forKey: fullUrl as NSURL) {
            presenter?.fetchImageSuccess(img: image)
        } else {
            var request = URLRequest(url: fullUrl)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let responseData = data else { return }
                if let img = UIImage(data: responseData) {
                    cachedImage.setObject(img, forKey: fullUrl as NSURL)
                    self?.presenter?.fetchImageSuccess(img: img)
                }
            }.resume()
        }
    }

}