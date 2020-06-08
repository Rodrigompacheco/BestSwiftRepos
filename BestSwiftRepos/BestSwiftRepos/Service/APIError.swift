//
//  APIError.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

enum APIError: Error {
    case custom(String)
}

extension APIError {
    static var makeRequest: APIError {
        return APIError.custom("Couldn't make request.")
    }
    
    static var decode: APIError {
        return APIError.custom("Couldn't decode data.")
    }
    
    static var invalidURL: APIError {
        return APIError.custom("Invalid URL.")
    }
    
    static var invalidData: APIError {
           return APIError.custom("Invalid Data.")
    }
}
