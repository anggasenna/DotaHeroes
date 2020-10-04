//
//  Extentions.swift
//  DotaHeroes
//
//  Created by BRI on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImage(url: String?){
        let cachedImage = NSCache<NSURL, UIImage>()
        let home = URL(string: "https://api.opendota.com")
        guard let url = URL(string: url ?? "", relativeTo: home) else { return }
        
        
        if let image = cachedImage.object(forKey: url as NSURL) {
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                guard let responseData = data else { return }
                if let img = UIImage(data: responseData) {
                    cachedImage.setObject(img, forKey: url as NSURL)
                    DispatchQueue.main.async {
                        self?.image = UIImage(data: responseData)
                    }
                }
            }.resume()
        }
    }
}
