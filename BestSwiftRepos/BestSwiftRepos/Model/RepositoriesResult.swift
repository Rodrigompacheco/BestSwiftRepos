//
//  RepositoriesResult.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

struct RepositoriesResult: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount
        case incompleteResults
        case items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        incompleteResults = try values.decode(Bool.self, forKey: .incompleteResults)
        items = try values.decode([Repository].self, forKey: .items)
    }
    
    init(totalCount: Int, incompleteResults: Bool, items: [Repository]) {
        self.totalCount = totalCount
        self.incompleteResults = incompleteResults
        self.items = items
    }
}
