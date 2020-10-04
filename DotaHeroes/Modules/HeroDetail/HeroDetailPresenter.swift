//
//  HeroDetailPresenter.swift
//  DotaHeroes
//
//  Created by BRI on 04/10/20.
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
    
    func getHeroImage(url: String?) {
        interactor?.loadHeroImage(url: url)
    }
    
}

extension HeroDetailPresenter: HeroDetailInteractorToPresenter {
    
    func fetchSimilarHeroSuccess(data: [Hero]) {
        view?.showSimilarHeroes(data: data)
    }
    
    func fetchImageSuccess(img: UIImage) {
        view?.showImage(img: img)
    }
    
    func fetchHeroFailed(message: String) {
        view?.showError(message: message)
    }
    
}
