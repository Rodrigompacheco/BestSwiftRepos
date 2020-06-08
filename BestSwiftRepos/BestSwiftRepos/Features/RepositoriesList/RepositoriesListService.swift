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
    private let api: Provider
    private let paginator: Paginator<Repository>
    
    init(api: Provider = APIProvider()) {
        self.api = api
        self.paginator = Paginator()
    }
}

extension RepositoriesService: RepositoriesInput {
    func fetchRepositories() {
        let endpoint = APIEndpoint.repositories(offset: paginator.offset)
        
        paginator.isLoading = true
        
        api.request(for: endpoint) { [weak self] (result: Result<DataPackage<Repository>, Error>) in
            guard let self = self else { return }
            
            switch result {
            case .success(let dataPackage):
                let state = self.paginator.paginate(dataPackage: dataPackage)
                let repositories = self.paginator.results
                self.output?.requestSucceded(repositories: repositories, state: state)
            case .failure(_):
                self.output?.requestFailed(error: APIError.makeRequest)
            }
        }
    }
    
    func loadingStatus() -> Bool {
        return paginator.isLoading
    }
    
    func hasMoreToDownloadStatus() -> Bool {
        return paginator.hasMore
    }
}
