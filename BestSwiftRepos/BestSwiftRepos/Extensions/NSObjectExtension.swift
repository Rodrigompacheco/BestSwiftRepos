//
//  NSObjectExtension.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
