//
//  AsyncFetcherOperation.swift
//  DotaHeroes
//
//  Created by BRI on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation

class AsyncFetcherOperation: Operation {

    let identifier: NSURL
    
    private(set) var fetchedData: UIImage?

    init(identifier: NSURL) {
        self.identifier = identifier
    }

    override func main() {
        // Wait for a second to mimic a slow operation.
        Thread.sleep(until: Date().addingTimeInterval(1))
        guard !isCancelled else { return }
        
        fetchedData = UIImage()
    }
}
