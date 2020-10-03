//
//  HeroCell.swift
//  DotaHeroes
//
//  Created by BRI on 03/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import UIKit

class HeroCell: UICollectionViewCell {
    
    @IBOutlet weak var heroImage: UIImageView!
    @IBOutlet weak var heroNameLabel: UILabel!
    
    func loadImage(url: String) {
        let home = URL(string: "https://api.opendota.com")
        guard let url = URL(string: url, relativeTo: home) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self?.heroImage.image = UIImage(data: data)
            }
            
        }.resume()
    }
}
