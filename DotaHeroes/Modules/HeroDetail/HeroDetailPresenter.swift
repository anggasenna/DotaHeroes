//
//  HeroDetailPresenter.swift
//  DotaHeroes
//
//  Created by Angga on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailPresenter: HeroDetailViewToPresenter {

    var view: HeroDetailPresenterToView?
    
    var interactor: HeroDetailPresenterToInteractor?
    
    var router: HeroDetailPresenterToRouter?
    
    func viewDidLoad(with data: Hero?) {
        interactor?.loadSimilarHeroes(with: data)
    }
    
}

extension HeroDetailPresenter: HeroDetailInteractorToPresenter {
    
    func fetchSimilarHeroSuccess(data: [Hero]) {
        view?.showSimilarHeroes(data: data)
    }

    func fetchHeroFailed(message: String) {
        view?.showError(message: message)
    }
    
}
