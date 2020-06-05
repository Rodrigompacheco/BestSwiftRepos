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
            return "/search/repositories"
        }
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems: [URLQueryItem] = []
        switch self {
        case .repositories(let offset):
            queryItems.append(contentsOf: [
                URLQueryItem(name: "q", value: "language:swift"),
                URLQueryItem(name: "per_page", value: offset.description)
            ])
        }
        return queryItems
    }
    
    func makeUrl() throws -> URL {
        var components = URLComponents(string: APIEndpoint.baseUrl + path)
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        
        return url
    }
}
