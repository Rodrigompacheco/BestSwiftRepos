//
//  ActivityIndicatorProtocol.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

protocol ActivityIndicatorTableItemView: class {
    func setup()
    func startAnimating()
    func stopAnimating()
}
