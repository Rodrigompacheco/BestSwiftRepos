//
//  RepositoryTableItemPresenter.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class RepositoryTableItemPresenter {
    
    private weak var view: RepositoryTableItemView?
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func attachView(_ view: RepositoryTableItemView) {
        self.view = view
        setupView()
    }

    func setupView() {
        view?.setupView()
        view?.setRepoTitle("Repositório:")
        view?.setRepoStarsTitle("Estrelas:")
        view?.setAuthorTitle("Autor:")
        view?.setRepoName(repository.name)
        view?.setRepoStars(String(repository.stars))
        view?.setAuthorName(repository.author.name)
        view?.setAuthorAvatar(repository.author.avatar)
    }
}
