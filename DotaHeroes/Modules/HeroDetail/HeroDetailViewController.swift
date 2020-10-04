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
    @IBOutlet weak var heroTypeImage: UIImageView!
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
    private let asyncFetcher = AsyncFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad(with: hero)
        setupView()
    }
    
    func setupView(){
        heroImage.loadImage(url: hero?.img)
        heroTypeImage.image = hero?.attack_type == "Ranged" ? UIImage(named: "Bow") : UIImage(named: "Cross Swords")
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

extension HeroDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarHeroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SimilarHeroCell", for: indexPath) as! SimilarHeroCell
        let hero = similarHeroes[indexPath.item]
        cell.imgAddress = hero.img
        let dom = URL(string: "https://api.opendota.com/api/herostats")
        let fullUrl = URL(string: hero.img ?? "", relativeTo: dom)
        if let fetchedData = asyncFetcher.fetchedData(for: fullUrl! as NSURL) {
            cell.heroImage.image = fetchedData
        } else {
            cell.heroImage.image = UIImage()
            asyncFetcher.fetchAsync(fullUrl! as NSURL) { fetchedData in
                DispatchQueue.main.async {
                    guard cell.imgAddress == hero.img else { return }
                    cell.heroImage.image = fetchedData
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let hero = similarHeroes[indexPath.row]
            let dom = URL(string: "https://api.opendota.com/api/herostats")
            let fullUrl = URL(string: hero.img ?? "", relativeTo: dom)
            asyncFetcher.fetchAsync(fullUrl! as NSURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let hero = similarHeroes[indexPath.row]
            let dom = URL(string: "https://api.opendota.com/api/herostats")
            let fullUrl = URL(string: hero.img ?? "", relativeTo: dom)
            asyncFetcher.cancelFetch(fullUrl! as NSURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 4
        let height = collectionView.frame.height - 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
}

extension HeroDetailViewController: HeroDetailPresenterToView {
    
    func showSimilarHeroes(data: [Hero]) {
        similarHeroes = data
        DispatchQueue.main.async {
            self.similarHeroesCollectionView.reloadData()
        }
    }

    func showError(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default){ action in
            alert.dismiss(animated: true, completion: nil)
        })
        DispatchQueue.main.async {
            self.present(alert,animated: true)
        }
    }
    
    
}

class SimilarHeroCell: UICollectionViewCell {
    @IBOutlet weak var heroImage: UIImageView!
    var imgAddress: String?
}
