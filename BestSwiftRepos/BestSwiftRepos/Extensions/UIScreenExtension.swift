//
//  UIScreenExtension.swift
//  BestSwiftRepos
//
//  Created by Rodrigo Pacheco on 06/06/20.
//  Copyright © 2020 Rodrigo Pacheco. All rights reserved.
//
import UIKit

extension UIScreen {
    
    public enum ScreenWidth {
        case reduced, regular, extended
    }
    
    static public var width: ScreenWidth {
        if main.bounds.width <= 320 {
            // iPhone 5S and earlier
            return .reduced
        } else if main.bounds.width < 414 {
            // iPhone 6, 6S and 7, X, XS
            return .regular
        }
        // iPhone Plus, XR, XSMax
        return .extended
    }
    
    public static var screenFactor: CGFloat {
        switch UIScreen.width {
        case .reduced:
            return 0.77
        case .regular:
            return 0.9
        case .extended:
            return 1.0
        }
    }
    
    public static var isReduced: Bool {
        return UIScreen.width == .reduced
    }
    
    public static var isIPhoneX: Bool {
        if main.bounds.height > 736 {
            return true
        } else {
            return false
        }
    }
}

