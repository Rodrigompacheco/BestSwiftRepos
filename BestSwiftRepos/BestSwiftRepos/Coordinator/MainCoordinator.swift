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
        navigationController.navigationBar.barTintColor = AppPalleteColors.navigationBarColor
        navigationController.navigationBar.tintColor = .white
    }
    
    func start() {
        let service = RepositoriesService()
        let viewController = RepositoriesListViewController(presenter: RepositoriesListPresenter(service: service))
        viewController.title = "Repositórios"
        navigationController.pushViewController(viewController, animated: false)
    }
}
