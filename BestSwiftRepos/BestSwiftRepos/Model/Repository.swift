//
//  Repository.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let stars: Int
    let author: Author
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case stars = "stargazers_count"
        case author = "owner"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        stars = try values.decode(Int.self, forKey: .stars)
        author = try values.decode(Author.self, forKey: .author)
    }
      
    init(id: Int, name: String, stars: Int, author: Author) {
        self.id = id
        self.name = name
        self.stars = stars
        self.author = author
    }
}
