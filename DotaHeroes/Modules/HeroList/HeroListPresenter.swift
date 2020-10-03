//
//  HeroListPresenter.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation

class HeroListPresenter: HeroListViewToPresenter {
    
    var view: HeroListPresenterToView?
    
    var interactor: HeroListPresenterToInteractor?
    
    var router: HeroListPresenterToRouter?
    
    func viewDidLoad() {
        interactor?.loadHeroes()
        interactor?.loadFilter()
    }
    
    func showHeroDetail() {
        
    }
    
    func filterHeroes(type: HeroRole) {
        interactor?.loadFilteredHeroes(with: type)
    }
    
}

extension HeroListPresenter: HeroListInteractorToPresenter {
    
    func fetchHeroSuccess(data: [Hero]) {
        view?.showHeroes(data: data)
    }
    
    func fetchFilter(data: [HeroRole]) {
        view?.showFilter(data: data)
    }
    
    func filterHeroesSuccess(data: [Hero]) {
        view?.showHeroes(data: data)
    }
    
    func fetchHeroFailed(message: String) {
        view?.showError(message: message)
    }
    
}
