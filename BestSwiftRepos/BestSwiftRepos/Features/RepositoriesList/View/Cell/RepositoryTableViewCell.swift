//
//  RepositoryTableViewCell.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit
import SnapKit

final class RepositoryTableViewCell: UITableViewCell {
    
    private var repositoryLabel = UILabel()
    private var starsLabel = UILabel()
    private var authorLabel = UILabel()
    private var repoNameLabel = UILabel()
    private var repoStarsLabel = UILabel()
    private var authorNameLabel = UILabel()
    private var authorAvatarImageView = UIImageView()
    private var starsImageView = UIImageView()
    private var cardView = UIView()
    private var lineSeparatorView = UIView()
    
    private var presenter: RepositoryTableItemPresenter?

    func attachPresenter(_ presenter: RepositoryTableItemPresenter) {
        self.presenter = presenter
        presenter.attachView(self)
    }
    
    private func setupCardView() {
        self.addSubview(cardView)
        
        cardView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalTo(10)
        }
        
        cardView.backgroundColor = .white
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 2
        cardView.layer.shadowOpacity = 0.5
    }
    
    private func setupRepositoryLabel() {
        self.addSubview(repositoryLabel)
        
        repositoryLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.leading.equalTo(5)
        }
    }
    
    private func setupStarsLabel() {
        cardView.addSubview(starsLabel)
        
        starsLabel.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.trailing.equalTo(5)
        }
    }
    
    private func setupAuthorLabel() {
        cardView.addSubview(authorLabel)
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(lineSeparatorView).offset(screenBased(regular: -5, reduced: 3, extended: -10))
            $0.leading.equalTo(5)
        }
    }
    
    private func setupRepoNameLabel() {
        cardView.addSubview(repoNameLabel)
        
        repoNameLabel.snp.makeConstraints {
            $0.top.equalTo(repositoryLabel).offset(screenBased(regular: -5, reduced: 3, extended: -10))
            $0.leading.equalTo(repositoryLabel.snp.leading)
        }
    }
    
    private func setupRepoStarsLabel() {
        cardView.addSubview(repoStarsLabel)
        
        repoStarsLabel.snp.makeConstraints {
            $0.top.equalTo(starsLabel).offset(screenBased(regular: -5, reduced: 3, extended: -10))
            $0.trailing.equalTo(5)
        }
    }
    
    private func setupAuthorAvatarImageView() {
        cardView.addSubview(authorAvatarImageView)
        
        authorAvatarImageView.snp.makeConstraints {
            $0.top.equalTo(authorLabel).offset(screenBased(regular: -5, reduced: 3, extended: -10))
            $0.leading.equalTo(authorLabel.snp.leading)
            $0.bottom.equalTo(20)
        }
    }
    
    private func setupAuthorNameLabell() {
        cardView.addSubview(authorNameLabel)
        
        authorNameLabel.snp.makeConstraints {
            $0.top.equalTo(authorAvatarImageView.snp.top)
            $0.leading.equalTo(authorAvatarImageView).offset(5)
        }
    }
    
    private func setupStarsImageView() {

    }
    
    private func setupLineSeparatorView() {
        cardView.addSubview(lineSeparatorView)
        
        lineSeparatorView.snp.makeConstraints {
            $0.top.equalTo(repoNameLabel).offset(screenBased(regular: -5, reduced: 3, extended: -10))
            $0.leading.trailing.equalTo(10)
        }
    }
}

extension RepositoryTableViewCell: RepositoryTableItemView {
    func setupView() {
        setupCardView()
        setupRepositoryLabel()
        setupStarsLabel()
        setupAuthorLabel()
        setupRepoNameLabel()
        setupRepoStarsLabel()
        setupAuthorAvatarImageView()
        setupAuthorNameLabell()
        setupStarsImageView()
        setupLineSeparatorView()
    }
    
    func setRepoTitle(_ title: String) {
        repositoryLabel.text = title
    }
    
    func setRepoStarsTitle(_ title: String) {
        repoStarsLabel.text = title
    }
    
    func setAuthorTitle(_ title: String) {
        authorLabel.text = title
    }
    
    func setRepoName(_ name: String) {
        repoNameLabel.text = name
    }
    
    func setRepoStars(_ stars: String) {
        repoStarsLabel.text = stars
    }
    
    func setAuthorName(_ name: String) {
        authorNameLabel.text = name
    }
    
    func setAuthorAvatar(_ photo: String) {
        authorAvatarImageView.load(thumbnailImage: photo)
    }
}
