//
//  HeroListPresenter.swift
//  DotaHeroes
//
//  Created by Angga on 03/10/20.
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

    func showHeroDetail(view navigationController: HeroListPresenterToView, data: Hero) {
        router?.pushToHeroDetail(view: navigationController, data: data)
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
