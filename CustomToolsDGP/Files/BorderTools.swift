//
//  BorderTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

extension UIView {
    
    public func setBorderLikeTextField() {
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.9
        self.layer.borderColor = #colorLiteral(red: 0.8235294118, green: 0.8235294118, blue: 0.8235294118, alpha: 1)
    }
    
}
