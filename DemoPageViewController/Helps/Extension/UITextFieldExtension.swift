//
//  Extention.swift
//  TimeKeeping
//
//  Created by Đinh Ngọc Vũ on 8/13/18.
//  Copyright © 2018 GEM. All rights reserved.
//

import UIKit

extension UITextField {
    func setIsOnFocus(_ isOnFocus: Bool) {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(1.0)
        
        border.borderColor = isOnFocus ? UIColor.pumpkinOrange.cgColor : UIColor.silver.cgColor
        
        let frameWidth = self.frame.size.width
        let frameHeight = self.frame.size.height
        border.frame = CGRect(x: 0,
                              y: frame.size.height - width,
                              width: frameWidth,
                              height: frameHeight)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
        self.textColor = isOnFocus ? UIColor.frenchBlue : UIColor.steelGrey
    }
    
    func setBorder(_ color: UIColor, _ width: Float) {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(width)
        
        border.borderColor = color.cgColor
        
        let frameWidth = self.frame.size.width
        let frameHeight = self.frame.size.height
        border.frame = CGRect(x: 0,
                              y: frame.size.height - width,
                              width: frameWidth,
                              height: frameHeight)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    open override func drawHierarchy(in rect: CGRect, afterScreenUpdates afterUpdates: Bool) -> Bool {
        super.drawHierarchy(in: rect, afterScreenUpdates: afterUpdates)
        self.frame = rect
        return true
    }
}
