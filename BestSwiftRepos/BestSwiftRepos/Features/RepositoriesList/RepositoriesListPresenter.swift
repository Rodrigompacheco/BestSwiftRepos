//
//  RepositoriesListPresenter.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class RepositoriesListPresenter {
    
    private let service: RepositoriesInput
    private var repositories: [Repository] = []
    private weak var view: RepositoriesView?
    
    init(service: RepositoriesInput) {
        self.service = service
        self.service.output = self
    }
    
    func attachView(view: RepositoriesView) {
        self.view = view
        service.fetchRepositories(100)
    }
    
    func getTotalRepositories() -> Int {
        return repositories.count
    }
    
    func getRepository(at index: Int) -> Repository? {
        guard index < repositories.count else { return nil }
        
        return repositories[index]
    }
}

extension RepositoriesListPresenter: RepositoriesOutput {
    func requestSucceded(repositories: [Repository]) {
        self.repositories = repositories
        view?.reloadData()
    }
    
    func requestFailed(error: APIError) {
        var errorMessage = ""
        
        switch error {
        default:
            errorMessage = "Erro ao carregar a lista"
        }
        view?.showAlert(errorMessage)
    }
}
