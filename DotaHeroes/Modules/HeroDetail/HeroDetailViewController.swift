//
//  HeroDetailViewController.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import UIKit

class HeroDetailViewController: UIViewController {

    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    @IBOutlet weak var heroRoleLabel: UILabel!
    @IBOutlet weak var similarHeroesCollectionView: UICollectionView!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var baseHealthLabel: UILabel!
    @IBOutlet weak var baseArmorLabel: UILabel!
    @IBOutlet weak var baseManaLabel: UILabel!
    @IBOutlet weak var moveSpeedLabel: UILabel!
    @IBOutlet weak var primaryAttrLabel: UILabel!
    
    var presenter: HeroDetailViewToPresenter?
    var hero: Hero?
    var similarHeroes: [Hero] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad(with: hero)
        setupView()
    }
    
    func setupView(){
        heroImage.loadImage(url: hero?.img)
        heroNameLabel.text = hero?.localized_name
        heroRoleLabel.text = ListFormatter.localizedString(byJoining: hero?.roles?.map({ $0.rawValue }) ?? [])
        baseAttackLabel.text = "\(hero?.base_attack_max ?? 0)"
        baseHealthLabel.text = "\(hero?.base_health ?? 0)"
        baseArmorLabel.text = "0"
        baseManaLabel.text = "\(hero?.base_mana ?? 0)"
        moveSpeedLabel.text = "\(hero?.move_speed ?? 0)"
        primaryAttrLabel.text = hero?.primary_attr
    }


}

extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarHeroCell", for: indexPath) as! SimilarHeroCell
        cell.heroImage.loadImage(url: similarHeroes[indexPath.item].img)
        return cell
    }
    
    
}

extension HeroDetailViewController: HeroDetailPresenterToView {
    
    
    func showSimilarHeroes(data: [Hero]) {
        similarHeroes = data
        DispatchQueue.main.async {
            self.similarHeroesCollectionView.reloadData()
        }
    }
    
    func showImage(img: UIImage) {
//        DispatchQueue.main.async {
//            self.heroImage.image = img
//        }
    }
    
    func showError(message: String) {
        print(message)
    }
    
    
}

class SimilarHeroCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: UIImageView!
}
