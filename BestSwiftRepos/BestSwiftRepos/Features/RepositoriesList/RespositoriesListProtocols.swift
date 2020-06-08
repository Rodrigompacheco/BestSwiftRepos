//
//  RespositoriesProtocols.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

protocol RepositoryTableItemView: class {
    func setupView()
    func setRepoTitle(_ title: String)
    func setRepoStarsTitle(_ title: String)
    func setAuthorTitle(_ title: String)
    func setRepoName(_ name: String)
    func setRepoStars(_ stars: String)
    func setAuthorName(_ name: String)
    func setAuthorAvatar(_ photo: String)
}

protocol RepositoriesView: class {
    func updateScrollTopBack(_ status: Bool)
    func reloadData(_ state: DataState)
    func showAlert(_ message: String)
}

protocol RepositoriesInput: class {
    var output: RepositoriesOutput? { get set }
    func fetchRepositories()
    func loadingStatus() -> Bool
    func hasMoreToDownloadStatus() -> Bool
}

protocol RepositoriesOutput: class {
    func requestSucceded(repositories: [Repository], state: DataState)
    func requestFailed(error: APIError)
}
