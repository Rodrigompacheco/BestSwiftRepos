//
//  APIProvider.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

final class APIProvider {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: APIEndpoint,
                               completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let url = try endpoint.makeUrl()
            print(url)
            session.dataTask(with: url) { (data, _, error) in
                guard let data = data else {
                    let newError = error == nil ? APIError.invalidData : error!
                    completion(.failure(newError))
                    return
                }
                
                let jsonDecoder = JSONDecoder()
                do {
                    let model = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
