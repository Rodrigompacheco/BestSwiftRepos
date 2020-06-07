//
//  DataPackage.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

struct DataPackage<T>: Decodable where T: Decodable {
    let totalCount: Int
    let items: [T]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

enum DataState {
    case notLoaded
    case loading
    case initial
    case inserted([IndexPath])
    case error(APIError)
}

final class Paginator<T> where T: Decodable {
    var hasMore = true
    var isLoading = false
    var offset = 1
    var results: [T] = []
    
    func paginate(dataPackage: DataPackage<T>) -> DataState {
        let lastResultIndex = self.results.count
        self.results += dataPackage.items
        let indexPaths = (lastResultIndex..<self.results.count).map { IndexPath(row: $0, section: 0) }
        let changeState: DataState = self.offset == 1 ? .initial : .inserted(indexPaths)
        self.offset += 1
        self.hasMore = self.results.count < dataPackage.totalCount
        self.isLoading = false
        return changeState
//        if offset == 0 {
//            self.results = dataPackage.items
//            self.initialOffset = dataPackage.items.count
//            self.offset = self.initialOffset
//        } else {
//            self.results.append(contentsOf: dataPackage.items.suffix(initialOffset))
//        }
//        let indexPaths = ((self.offset - self.initialOffset)..<self.results.count).map { IndexPath(row: $0, section: 0) }
//        let changeState: DataState = self.offset == self.initialOffset ? .initial : .inserted(indexPaths)
//        self.offset += self.initialOffset
//        self.hasMore = self.results.count < dataPackage.totalCount
//        self.isLoading = false
//        return changeState
    }
}
