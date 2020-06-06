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
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decode(Int.self, forKey: .totalCount)
        items = try values.decode([Repository].self, forKey: .items)
    }
    
    init(totalCount: Int, items: [Repository]) {
        self.totalCount = totalCount
        self.items = items
    }
}
