//
//  HeroListViewController.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import UIKit

class HeroListViewController: UIViewController {

    @IBOutlet weak var filterTableView: UITableView!
    @IBOutlet weak var heroCollectionView: UICollectionView!
    
    var presenter: HeroListViewToPresenter?
    var heroes: [Hero] = []
    var roles: [HeroRole] = []
    
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
        self.navigationItem.prompt = roles[indexPath.row].rawValue
        presenter?.filterHeroes(type: roles[indexPath.row])
    }
}

extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroCell", for: indexPath) as! HeroCell
        cell.loadImage(url: heroes[indexPath.row].img ?? "")
        cell.heroNameLabel.text = heroes[indexPath.row].localized_name
        return cell
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
        print(message)
    }
    
    func showFilter(data: [HeroRole]) {
        roles = data
        filterTableView.reloadData()
        self.navigationItem.prompt = roles.last?.rawValue
    }
    
}
