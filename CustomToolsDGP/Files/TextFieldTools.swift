//
//  TextFieldTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 23/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class TextFieldTools {
    
    public init() {
        
    }
    
    public func setTextFieldErrorBorder(textField: UITextField, correct: Bool) {
        if correct {
            setTextFieldRight(textField: textField)
        } else {
            setTextFieldError(textField: textField)
        }
    }
    
    func setTextFieldError(textField: UITextField) {
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 0.8
        textField.layer.borderColor = #colorLiteral(red: 0.7713251114, green: 0.01506985817, blue: 0.1164119914, alpha: 1)
    }
    
    func setTextFieldRight(textField: UITextField) {
        textField.layer.cornerRadius = 2
        textField.layer.borderWidth = 0.9
        textField.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
}
