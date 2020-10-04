//
//  HeroDetailProtocols.swift
//  DotaHeroes
//
//  Created by BRI on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

protocol HeroDetailViewToPresenter {
    var view: HeroDetailPresenterToView? {get set}
    var interactor: HeroDetailPresenterToInteractor? {get set}
    var router: HeroDetailPresenterToRouter? {get set}
    func viewDidLoad(with data: Hero?)
}

protocol HeroDetailPresenterToRouter {
    static func createModule(data: Hero) -> UIViewController
}

protocol HeroDetailPresenterToInteractor {
    var presenter: HeroDetailInteractorToPresenter? {get set}
    func loadSimilarHeroes(with data: Hero?)
}

protocol HeroDetailInteractorToPresenter {
    func fetchSimilarHeroSuccess(data: [Hero])
    func fetchHeroFailed(message: String)
}

protocol HeroDetailPresenterToView {
    func showSimilarHeroes(data: [Hero])
    func showError(message: String)
}

