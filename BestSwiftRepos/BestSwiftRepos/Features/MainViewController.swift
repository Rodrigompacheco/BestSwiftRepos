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
    }
}
