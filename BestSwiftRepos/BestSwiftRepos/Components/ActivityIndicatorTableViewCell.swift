//
//  ActivityIndicatorTableViewCell.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit
import SnapKit

class ActivityIndicatorTableViewCell: UITableViewCell {

    static let identifier = String(describing: ActivityIndicatorTableViewCell.self)
    private let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    private var presenter: ActivityIndicatorTableItemPresenter?
    
    func attachPresenter(_ presenter: ActivityIndicatorTableItemPresenter) {
        self.presenter = presenter
        presenter.attachView(self)
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupActivityIndicator() {
        self.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.centerY.equalTo(self)
        }
    }
}

extension ActivityIndicatorTableViewCell: ActivityIndicatorTableItemView {
    func setup() {
        setupView()
        setupActivityIndicator()
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
   
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
