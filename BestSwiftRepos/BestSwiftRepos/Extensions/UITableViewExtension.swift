//
//  UITableViewExtension.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit

extension UITableView {
    func register(for aClass: AnyClass) {
        let identifier = String(describing: aClass)
        register(
            UINib(nibName: identifier, bundle: Bundle(for: aClass)),
            forCellReuseIdentifier: identifier
        )
    }
}

