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
    
    static let identifier = String(describing: RepositoryTableViewCell.self)
    
    private var repositoryLabel = UILabel()
    private var starsLabel = UILabel()
    private var authorLabel = UILabel()
    private var repoNameLabel = UILabel()
    private var repoStarsLabel = UILabel()
    private var authorNameLabel = UILabel()
    private var authorAvatarImageView = UIImageView()
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
            $0.top.leading.equalTo(10)
            $0.bottom.trailing.equalTo(-10)
        }
        
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10
        cardView.layer.shadowOffset = CGSize(width: 0, height: 3)
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOpacity = 0.7
    }
    
    private func setupRepositoryLabel() {
        cardView.addSubview(repositoryLabel)

        repositoryLabel.snp.makeConstraints {
            $0.top.equalTo(cardView).offset(10)
            $0.leading.equalTo(10)
        }
        
        repositoryLabel.font = AppFonts.cardTitle
    }
    
    private func setupStarsLabel() {
        cardView.addSubview(starsLabel)
        
        starsLabel.snp.makeConstraints {
            $0.centerY.equalTo(repositoryLabel)
            $0.trailing.equalTo(cardView).offset(-10)
        }
        
        starsLabel.font = AppFonts.cardTitle
    }
    
    private func setupAuthorLabel() {
        cardView.addSubview(authorLabel)
        
        authorLabel.snp.makeConstraints {
            $0.top.equalTo(lineSeparatorView.snp.bottom).offset(screenBased(regular: 18, reduced: 15, extended: 20))
            $0.leading.equalTo(repositoryLabel.snp.leading)
        }
        
        authorLabel.font = AppFonts.cardTitle
    }
    
    private func setupRepoNameLabel() {
        cardView.addSubview(repoNameLabel)
        
        repoNameLabel.snp.makeConstraints {
            $0.top.equalTo(repositoryLabel.snp.bottom).offset(screenBased(regular: 4, reduced: 3, extended: 5))
            $0.leading.equalTo(repositoryLabel.snp.leading)
        }
        
        repoNameLabel.font = AppFonts.cardSubtitle
        repoNameLabel.textColor = AppColorPalette.bluePetroleum
    }
    
    private func setupRepoStarsLabel() {
        cardView.addSubview(repoStarsLabel)
        
        repoStarsLabel.snp.makeConstraints {
            $0.centerY.equalTo(repoNameLabel)
            $0.trailing.equalTo(starsLabel.snp.trailing)
        }
        
        repoStarsLabel.font = AppFonts.cardSubtitle
        repoStarsLabel.textColor = AppColorPalette.yellowGold
    }
    
    private func setupAuthorAvatarImageView() {
        cardView.addSubview(authorAvatarImageView)
        
        authorAvatarImageView.snp.makeConstraints {
            $0.top.equalTo(lineSeparatorView.snp.bottom).offset(screenBased(regular: 18, reduced: 15, extended: 20))
            $0.trailing.equalTo(starsLabel.snp.trailing)
            $0.height.width.equalTo(48)
        }
        
        authorAvatarImageView.layer.cornerRadius = 10
        authorAvatarImageView.clipsToBounds = true
    }
    
    private func setupAuthorNameLabell() {
        cardView.addSubview(authorNameLabel)
        
        authorNameLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(screenBased(regular: 4, reduced: 3, extended: 5))
            $0.leading.equalTo(authorLabel.snp.leading)
        }
        
        authorNameLabel.font = AppFonts.cardSubtitle
        authorNameLabel.textColor = AppColorPalette.bluePetroleum
    }

    private func setupLineSeparatorView() {
        cardView.addSubview(lineSeparatorView)
        
        lineSeparatorView.snp.makeConstraints {
            $0.top.equalTo(repoNameLabel.snp.bottom).offset(screenBased(regular: 18, reduced: 15, extended: 20))
            $0.leading.equalTo(10)
            $0.trailing.equalTo(-10)
            $0.height.equalTo(1)
        }
        
        lineSeparatorView.backgroundColor = .lightGray
        lineSeparatorView.alpha = 0.5
    }
}

extension RepositoryTableViewCell: RepositoryTableItemView {
    func setupView() {
        self.selectionStyle = .none
        self.backgroundColor = AppColorPalette.mainBackground

        setupCardView()
        setupRepositoryLabel()
        setupStarsLabel()
        setupRepoNameLabel()
        setupRepoStarsLabel()
        setupLineSeparatorView()
        setupAuthorLabel()
        setupAuthorAvatarImageView()
        setupAuthorNameLabell()
    }
    
    func setRepoTitle(_ title: String) {
        repositoryLabel.text = title
    }
    
    func setRepoStarsTitle(_ title: String) {
        starsLabel.text = title
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
