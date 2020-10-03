//
//  HeroListRouter.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

class HeroListRouter: HeroListPresenterToRouter {
    
    static func createModule() -> UINavigationController {
        let view = UIStoryboard(name: "HeroList", bundle: .main)
            .instantiateInitialViewController() as! HeroListViewController
        let nav = UINavigationController(rootViewController: view)
        
        let presenter = HeroListPresenter()
        let interactor = HeroListInteractor()
        let router = HeroListRouter()
        
        view.presenter = presenter
        interactor.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        return nav
    }
    
    func pushToHeroDetail() {
        
    }
    
    
}
