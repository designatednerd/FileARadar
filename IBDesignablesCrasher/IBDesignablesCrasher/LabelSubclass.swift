//
//  LabelSubclass.swift
//  IBDesignablesCrasher
//
//  Created by Ellen Shapiro on 1/8/19.
//  Copyright © 2019 Bakken & Baeck. All rights reserved.
//

import UIKit

@IBDesignable
class LabelSubclass: UILabel {
    
    func commonInit() {
        self.textColor = Color.purple.toUIColor
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
