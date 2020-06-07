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
        fetchData()
    }
    
    func fetchData() {
        service.fetchRepositories()
    }
    
    func getTotalRepositories() -> Int {
        return repositories.count
    }
    
    func getRepository(at index: Int) -> Repository? {
        guard index < repositories.count else { return nil }
        
        return repositories[index]
    }
    
    func isLoading() -> Bool {
        return service.loadingStatus()
    }
    
    func hasMoreToDownload() -> Bool {
        return service.hasMoreToDownloadStatus()
    }
}

extension RepositoriesListPresenter: RepositoriesOutput {
    
    func requestSucceded(repositories: [Repository], state: DataState) {
        self.repositories = repositories
        view?.reloadData(state)
    }
    
    func requestFailed(error: APIError) {
        var errorMessage = ""
        
        switch error {
        default:
            errorMessage = "Número de requests excedido. Tente novamente em 60 minutos."
        }
        view?.showAlert(errorMessage)
    }
}
