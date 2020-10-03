//
//  HeroListInteractor.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation

class HeroListInteractor: HeroListPresenterToInteractor {
    
    

    var presenter: HeroListInteractorToPresenter?
    var heroes: [Hero] = []
    var filter: [HeroRole] = []
    var filteredHeroes: [Hero] = []
    
    func loadHeroes() {
        guard let url = URL(string: "https://api.opendota.com/api/herostats") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            let jsonDecoder = JSONDecoder()
            guard let data = data else { return }
            do {
                self?.heroes = try jsonDecoder.decode([Hero].self, from: data)
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
                return (hero.roles?.contains(type))!
            })
            print("count: \(filteredHeroes.count)")
            presenter?.filterHeroesSuccess(data: filteredHeroes)
        }
    }
    
    
}
