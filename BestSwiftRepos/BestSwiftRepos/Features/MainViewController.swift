//
//  MainViewController.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 04/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        var backgroundView = UIView(frame: self.view.bounds)
        backgroundView.backgroundColor = .blue
        self.view.addSubview(backgroundView)
        
        
        let apiProvider = APIProvider()
        let endpoint = APIEndpoint.repositories(offset: 1)
        
        apiProvider.request(for: endpoint) { [weak self] (result: Result<RepositoriesResult, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
                print("SUCESSO")
                print(dataPackage)
            case .failure(_):
                print("FALHOU")
            }
        }
    }
}
