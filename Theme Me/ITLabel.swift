//
//  ITLabel.swift
//  Theme Me
//
//  Created by Max Nelson on 7/24/17.
//  Copyright © 2017 Maxnelson. All rights reserved.
//

import UIKit

class ITLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init() {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        initializePhaseTwo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func initializePhaseTwo() {
        
    }
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        super.drawText(in: UIEdgeInsetsInsetRect(self.frame, insets))
    }
    
}
