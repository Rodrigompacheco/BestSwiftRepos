//
//  Repository.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

struct Repository: Codable {
    let id: String
    let nodeId: String
    let name: String
    let fullName: String
    let `private`: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case nodeId
        case name
        case fullName
        case `private`
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        nodeId = try values.decode(String.self, forKey: .nodeId)
        name = try values.decode(String.self, forKey: .name)
        fullName = try values.decode(String.self, forKey: .fullName)
        `private` = try values.decode(Bool.self, forKey: .`private`)
    }
      
    init(id: String, nodeId: String, name: String, fullName: String, `private`: Bool) {
        self.id = id
        self.nodeId = nodeId
        self.name = name
        self.fullName = fullName
        self.private = `private`
    }
}
