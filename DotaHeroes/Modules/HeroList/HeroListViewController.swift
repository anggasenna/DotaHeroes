//
//  HeroListViewController.swift
//  DotaHeroes
//
//  Created by Angga on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import UIKit

class HeroListViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
    var presenter: HeroListViewToPresenter?
    var heroes: [Hero] = []
    var roles: [HeroRole] = []
    private let asyncFetcher = AsyncFetcher()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
    }
    
}

extension HeroListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as! FilterCell
        cell.typeLabel.text = roles[indexPath.row].rawValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 500
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.title = roles[indexPath.row].rawValue
        presenter?.filterHeroes(type: roles[indexPath.row])
    }
}

extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDataSourcePrefetching {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as! HeroCell
        let hero = heroes[indexPath.item]
        cell.imgAddress = hero.img
        let dom = URL(string: "https://api.opendota.com")
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
        cell.heroNameLabel.text = heroes[indexPath.row].localized_name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let hero = heroes[indexPath.row]
            let dom = URL(string: "https://api.opendota.com")
            let fullUrl = URL(string: hero.img ?? "", relativeTo: dom)
            asyncFetcher.fetchAsync(fullUrl! as NSURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let hero = heroes[indexPath.row]
            let dom = URL(string: "https://api.opendota.com")
            let fullUrl = URL(string: hero.img ?? "", relativeTo: dom)
            asyncFetcher.cancelFetch(fullUrl! as NSURL)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3) - 2
        let height = (collectionView.frame.height / 2) - 1
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showHeroDetail(view: self, data: heroes[indexPath.item])
    }
    
}

extension HeroListViewController: HeroListPresenterToView {

    func showHeroes(data: [Hero]) {
        heroes = data
        DispatchQueue.main.async {
            self.heroCollectionView.reloadData()
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
    
    func showFilter(data: [HeroRole]) {
        roles = data
        filterTableView.reloadData()
        self.title = roles.last?.rawValue
    }
    
}
