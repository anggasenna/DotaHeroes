//
//  AsyncFetcher.swift
//  DotaHeroes
//
//  Created by BRI on 04/10/20.
//  Copyright © 2020 Angga. All rights reserved.
//

import Foundation
import UIKit

class AsyncFetcher {
    private let serialAccessQueue = OperationQueue()
    private let fetchQueue = OperationQueue()
    private var completionHandlers = [NSURL: [(UIImage?) -> Void]]()
    private var cache = NSCache<NSURL, UIImage>()

    init() {
        serialAccessQueue.maxConcurrentOperationCount = 1
    }

    func fetchAsync(_ identifier: NSURL, completion: ((UIImage?) -> Void)? = nil) {
        serialAccessQueue.addOperation {
            if let completion = completion {
                let handlers = self.completionHandlers[identifier, default: []]
                self.completionHandlers[identifier] = handlers + [completion]
            }
            
            self.fetchData(for: identifier)
        }
    }

    func fetchedData(for identifier: NSURL) -> UIImage? {
        return cache.object(forKey: identifier as NSURL)
    }

    func cancelFetch(_ identifier: NSURL) {
        serialAccessQueue.addOperation {
            self.fetchQueue.isSuspended = true
            defer {
                self.fetchQueue.isSuspended = false
            }

            self.operation(for: identifier)?.cancel()
            self.completionHandlers[identifier] = nil
        }
    }

    private func fetchData(for identifier: NSURL) {
        guard operation(for: identifier) == nil else { return }
        
        if let data = fetchedData(for: identifier) {
            invokeCompletionHandlers(for: identifier, with: data)
        } else {
            let operation = AsyncFetcherOperation(identifier: identifier)
            
            operation.completionBlock = { [weak operation] in
                guard let fetchedData = operation?.fetchedData else { return }
                self.cache.setObject(fetchedData, forKey: identifier as NSURL)
                
                self.serialAccessQueue.addOperation {
                    self.invokeCompletionHandlers(for: identifier, with: fetchedData)
                }
            }
            
            fetchQueue.addOperation(operation)
        }
    }

    private func operation(for identifier: NSURL) -> AsyncFetcherOperation? {
        for case let fetchOperation as AsyncFetcherOperation in fetchQueue.operations
            where !fetchOperation.isCancelled && fetchOperation.identifier == identifier {
            return fetchOperation
        }
        
        return nil
    }

    private func invokeCompletionHandlers(for identifier: NSURL, with fetchedData: UIImage) {
        let completionHandlers = self.completionHandlers[identifier, default: []]
        self.completionHandlers[identifier] = nil

        for completionHandler in completionHandlers {
            completionHandler(fetchedData)
        }
    }
}


