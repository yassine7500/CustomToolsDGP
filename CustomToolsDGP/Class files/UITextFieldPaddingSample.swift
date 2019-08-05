//
//  UITextFieldPaddingSample.swift
//  CustomToolsDGP
//
//  Created by David Galán on 23/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

//import UIKit
//
//class UITextFieldPadding: UITextField {
//    
//    let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: self.insets)
//    }
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: self.insets)
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: self.insets)
//    }
//}
