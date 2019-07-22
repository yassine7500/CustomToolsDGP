//
//  ShadowTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


extension UIView {
    
    public func setShadow(offsetWidth: CGFloat = 0, offsetHeight: CGFloat = 10, shadowOpacity: Float = 0.4, shadowRadius: CGFloat = 16, shadowColor: CGColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)) {
        self.layer.shadowOffset = CGSize(width: offsetWidth, height: offsetHeight)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowColor =  shadowColor
    }
    
    public func setShadowSoft(cornerRadius: CGFloat = 2) {
        self.setShadow(offsetWidth: 0, offsetHeight: 1, shadowOpacity: 0.8, shadowRadius: 1, shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
        self.layer.cornerRadius = cornerRadius
    }
    
    public func setBorderLikeTextField() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.9
        self.layer.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
    }
    
}
