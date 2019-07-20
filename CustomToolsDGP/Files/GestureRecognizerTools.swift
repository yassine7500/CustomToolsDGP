//
//  GestureRecognizerTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


// hide keyboard when user touches outside keyboard
extension UIViewController {
    
    public func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

public class GestureRecognizerTools {
    
    public init() {
        
    }
    
    // set tap gesture recognizer for images
    public func setTapGestureRecognizer(object: UIImageView, target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        object.isUserInteractionEnabled = true
        object.addGestureRecognizer(tapGesture)
    }
    
    // set tap gesture recognizer for labels
    public func setTapGestureRecognizer(object: UILabel, target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        object.isUserInteractionEnabled = true
        object.addGestureRecognizer(tapGesture)
    }
    
    // set tap gesture recognizer for view
    public func setTapGestureRecognizer(object: UIView, target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        object.isUserInteractionEnabled = true
        object.addGestureRecognizer(tapGesture)
    }
    
    // set tap gesture recognizer for textView
    public func setTapGestureRecognizer(object: UITextView, target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        object.isUserInteractionEnabled = true
        object.addGestureRecognizer(tapGesture)
    }
    
    // set tap gesture recognizer for button
    public func setTapGestureRecognizer(object: UIButton, target: Any?, action: Selector?) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        object.isUserInteractionEnabled = true
        object.addGestureRecognizer(tapGesture)
    }
    
}




