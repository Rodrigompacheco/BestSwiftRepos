//
//  UIScrollViewExtension.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 07/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit

extension UIScrollView {
    var reachedBottom: Bool {
        let visibleHeight = frame.height - contentInset.top - contentInset.bottom
        let yPoint = contentOffset.y + contentInset.top
        let threshold = max(0.0, contentSize.height - visibleHeight)
        return yPoint > threshold
    }
}
