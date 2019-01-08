//
//  Fonts.swift
//  IBDesignableFontFollies
//
//  Created by Ellen Shapiro on 1/8/19.
//  Copyright © 2019 Bakken & Baeck. All rights reserved.
//

import UIKit

enum Font: String {
    case regular = "Znikomit"
    case bold = "AlbaMatter"
    case shadow = "AlbaSuper"
    case smallCaps = "ZnikomitSC"
    
    var fileExtension: String {
        switch self {
        case
             .bold,
             .shadow:
            return "ttf"
        case
            .regular,
            .smallCaps:
            return "otf"
        }
    }
    
    func toUIFont(size: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: size) {
            return font
        }

        // Comment this out when uncommenting below
        fatalError("Could not load font!")
        
        // Workaround: Load font with core text.
        // We could not get the font from just its name, we're probably in interface builder
//        guard self.loadFont() else {
//            fatalError("Could not load font!")
//        }
//
//        guard let reloadedFont = UIFont(name: self.rawValue, size: size) else {
//            fatalError("Reloaded font did not work!")
//        }
//
//        return reloadedFont
    }
    
    private func loadFont() -> Bool {
        guard let path = Bundle(for: AppDelegate.self).path(forResource: self.rawValue, ofType: self.fileExtension) else {
            return false
        }
        
        let url = URL(fileURLWithPath: path) as CFURL
        
        guard
            let dataProvider = CGDataProvider(url: url),
            let font = CGFont(dataProvider) else {
                return false
        }
        
        var error: Unmanaged<CFError>?
        guard CTFontManagerRegisterGraphicsFont(font, &error) else {
            debugPrint("Error registering font: \(String(describing: error?.takeUnretainedValue()))")
            return false
        }
        
        return true
    }
}
