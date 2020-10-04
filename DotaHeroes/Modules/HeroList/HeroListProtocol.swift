//
//  HeroListProtocol.swift
//  DotaHeroes
//
//  Created by Angga on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

protocol HeroListViewToPresenter {
    var view: HeroListPresenterToView? {get set}
    var interactor: HeroListPresenterToInteractor? {get set}
    var router: HeroListPresenterToRouter? {get set}
    func viewDidLoad()
    func filterHeroes(type: HeroRole)
    func showHeroDetail(view: HeroListPresenterToView, data: Hero)
}

protocol HeroListPresenterToRouter {
    static func createModule() -> UINavigationController
    func pushToHeroDetail(view: HeroListPresenterToView, data: Hero)
}

protocol HeroListPresenterToInteractor {
    var presenter: HeroListInteractorToPresenter? {get set}
    func loadHeroes()
    func loadFilter()
    func loadFilteredHeroes(with type: HeroRole)
}

protocol HeroListInteractorToPresenter {
    func fetchHeroSuccess(data: [Hero])
    func fetchFilter(data: [HeroRole])
    func filterHeroesSuccess(data: [Hero])
    func fetchHeroFailed(message: String)
}

protocol HeroListPresenterToView {
    func showHeroes(data: [Hero])
    func showFilter(data: [HeroRole])
    func showError(message: String)
}
