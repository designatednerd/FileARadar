//
//  LabelSubclasses.swift
//  IBDesignableFontFollies
//
//  Created by Ellen Shapiro on 1/8/19.
//  Copyright © 2019 Bakken & Baeck. All rights reserved.
//

import UIKit

@IBDesignable
class CustomFontLabel: UILabel {
    
    func commonInit() {
        // Subclasses should call this.
    }
    
    init() {
        super.init(frame: .zero)
        self.commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.commonInit()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.commonInit()
    }
}

@objc
class RegularLabel: CustomFontLabel {
    
    override func commonInit() {
        super.commonInit()
        self.font = Font.regular.toUIFont(size: 16)
    }
}

@objc
class BoldLabel: CustomFontLabel {
    
    override func commonInit() {
        super.commonInit()
        self.font = Font.bold.toUIFont(size: 18)
    }
}
