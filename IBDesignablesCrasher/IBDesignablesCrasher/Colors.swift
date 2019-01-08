//
//  Colors.swift
//  IBDesignablesCrasher
//
//  Created by Ellen Shapiro on 1/8/19.
//  Copyright © 2019 Bakken & Baeck. All rights reserved.
//

import UIKit

enum Color: String {
    case red
    case purple

    var toUIColor: UIColor {
        // 1. Crashes when accessed via `prepareForInterfaceBuilder`, works fine at runtime
        return UIColor(named: self.rawValue)!
        
        // 2. Crashes when accessed via `prepareForInterfaceBuilder`, works fine at runtime.
//        return UIColor(named: self.rawValue,
//                       in: .main,
//                       compatibleWith: nil)!
        
        // 3. Works when accessed via `prepareForInterfaceBuilder` and at runtime
//        return UIColor(named: self.rawValue,
//                       in: Bundle(for: AppDelegate.self),
//                       compatibleWith: nil)!
    }
}
