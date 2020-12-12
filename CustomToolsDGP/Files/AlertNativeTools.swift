//
//  AlertNativeTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 12/12/2020.
//  Copyright © 2020 David Galán. All rights reserved.
//

import UIKit

extension UIViewController {
    
    enum UIAlertActionOptions {
        case `default`
        case destructive
    }
    
    func showBasicAlert(title: String,
                        message: String,
                        buttonText: String,
                        alertStyle: UIAlertController.Style = .alert,
                        buttonStyle: UIAlertAction.Style = .default,
                        completion: @escaping (Bool) -> ()) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
            
            let buttonAction = UIAlertAction(title: buttonText, style: buttonStyle) {
                UIAlertAction in
                
                completion(true)
            }
            alert.addAction(buttonAction)
            
            self.present(alert, animated: true)
        }
    }
    
    
    func showAlertTwoOptions(title: String,
                             message: String,
                             buttonOneText: String,
                             buttonTwoText: String,
                             alertStyle: UIAlertController.Style = .alert,
                             buttonStyle: UIAlertActionOptions = .default,
                             completion: @escaping (Bool) -> ()) {
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
            var buttonStyleValue: UIAlertAction.Style = .default
            
            if buttonStyle == .destructive {
                buttonStyleValue = .destructive
            }
            
            let buttonActionOne = UIAlertAction(title: buttonOneText, style: buttonStyleValue) {
                UIAlertAction in
                completion(true)
            }
            alert.addAction(buttonActionOne)
            
            let buttonActionTwo = UIAlertAction(title: buttonTwoText, style: buttonStyleValue) {
                UIAlertAction in
                completion(false)
            }
            alert.addAction(buttonActionTwo)
            
            self.present(alert, animated: true)
        }
    }
    
}


