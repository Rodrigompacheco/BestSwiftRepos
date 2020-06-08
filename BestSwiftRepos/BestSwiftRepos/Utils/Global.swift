//
//  Global.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//

import UIKit

public func screenBased<T: Any>(regular: T, reduced: T? = nil, extended: T? = nil) -> T {
    
    if let reduced = reduced, UIScreen.isReduced {
        return reduced
    } else if let extended = extended, UIScreen.isIPhoneX {
        return extended
    }
    
    return regular
}
