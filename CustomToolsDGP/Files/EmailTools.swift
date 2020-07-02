//
//  EmailTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

extension String {
    
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.checkLastCharacterOfEmail())
    }
    
    public func openEmail() {
        if self.isValidEmail() {
            if let url = URL(string: "mailto:\(self.checkLastCharacterOfEmail())") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func checkLastCharacterOfEmail() -> String {
        
        var emailToCheck: String = self
        
        if emailToCheck.last == " " {
            emailToCheck = String(emailToCheck.dropLast())
        }
        
        return emailToCheck
    }
    
}
