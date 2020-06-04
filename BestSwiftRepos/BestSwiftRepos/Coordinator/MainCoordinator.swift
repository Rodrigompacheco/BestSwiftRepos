//
//  MainCoordinator.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
//    let marvelApiProvider: MarvelApiProvider = MarvelApiProvider()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.barTintColor = UIColor(red: 220/255, green: 55/255, blue: 48/255, alpha: 1.0)
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
//        let presenter = CharactersListPresenter(marvelApiProvider: marvelApiProvider)
//        presenter.presenterCoordinatorDelegate = self
//        let viewController = CharactersListViewController(presenter: presenter)
//        viewController.title = "Characters"
//        navigationController.pushViewController(viewController, animated: false)
        let viewController = MainViewController()
        navigationController.pushViewController(viewController, animated: false)
    }
}
