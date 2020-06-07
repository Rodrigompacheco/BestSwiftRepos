//
//  RepositoriesListService.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class RepositoriesService {
    
    var output: RepositoriesOutput?
    private let api: APIProvider
    
    init(api: APIProvider = APIProvider()) {
        self.api = api
    }
}

extension RepositoriesService: RepositoriesInput {
    func fetchRepositories(_ offset: Int) {
        let endpoint = APIEndpoint.repositories(offset: offset)
        
        api.request(for: endpoint) { [weak self] (result: Result<RepositoriesResult, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                self.output?.requestSucceded(repositories: data.items)
            case .failure(_):
                self.output?.requestFailed(error: APIError.makeRequest)
            }
        }
    }
}
