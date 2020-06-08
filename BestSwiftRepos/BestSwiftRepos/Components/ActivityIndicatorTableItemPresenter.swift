//
//  ActivityIndicatorTableItemPresenter.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

class ActivityIndicatorTableItemPresenter {
    
    private weak var view: ActivityIndicatorTableItemView?
    
    func attachView(_ view: ActivityIndicatorTableItemView) {
        self.view = view
        setupView()
    }
    
    func setupView() {
        view?.setup()
    }
    
    func startAnimating() {
        view?.startAnimating()
    }
    
    func stopAnimating() {
        view?.stopAnimating()
    }
}
