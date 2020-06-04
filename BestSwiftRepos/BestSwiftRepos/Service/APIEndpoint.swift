//
//  APIEndpoints.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

enum APIEndpoint {
    case repositories(offset: Int)
}

extension APIEndpoint {
    static let baseUrl = "https://api.github.com"
    
    var path: String {
        switch self {
        case .repositories:
            return "/search/repositories?q=language:swift&sort=stars"
        }
    }
    
    func makeUrl() throws -> URL {
        let components = URLComponents(string: APIEndpoint.baseUrl + path)
        
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        return url
    }
}
