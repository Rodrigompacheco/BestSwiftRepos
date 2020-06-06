//
//  Author.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 05/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class Author: Codable {
    let name: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case name = "login"
        case avatar = "avatar_url"
    }
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        avatar = try values.decode(String.self, forKey: .avatar)
    }
    
    init(name: String, avatar: String) {
        self.name = name
        self.avatar = avatar
    }
    
    func getName() -> String {
        return name
    }
    
    func getAvatarUrl() -> String {
        return avatar
    }
}
