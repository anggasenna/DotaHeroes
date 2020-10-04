//
//  HeroDetailRouter.swift
//  DotaHeroes
//
//  Created by Angga on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

class HeroDetailRouter: HeroDetailPresenterToRouter {
    
    static func createModule(data: Hero) -> UIViewController {
        let view = UIStoryboard(name: "HeroDetail", bundle: .main).instantiateInitialViewController() as! HeroDetailViewController
        let presenter = HeroDetailPresenter()
        let router = HeroDetailRouter()
        let interactor = HeroDetailInteractor()
        
        view.presenter = presenter
        view.hero = data
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
}
