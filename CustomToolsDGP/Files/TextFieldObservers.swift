//
//  TextFieldObservers.swift
//  CustomToolsDGP
//
//  Created by David Galán on 17/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UIKit

public protocol TextFieldProtocol {
    func passObjectToMove(insets: UIEdgeInsets, variableInt: CGFloat)
}

public enum TextFieldObserversOptions: String {
    case one
    case two
    case three
}

public class TextFieldObservers {
    

    
    public init() {}
    
    // VARIABLES
    private var delegateTextField: TextFieldProtocol?
    private var variableInt: CGFloat = 0
    
    //step.1 fill paremeters
    public func setVariables(delegate: TextFieldProtocol, variableInt: CGFloat = 0) {
        self.delegateTextField = delegate
        self.variableInt = variableInt
    }
    
    //step.2 Add observers for 'UIKeyboardWillShow' and 'UIKeyboardWillHide' notification.
    public func createObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //step.3 Add method to handle keyboardWillShow notification, we're using this method to adjust view/scrollview to show hidden textfield under keyboard.
    @objc func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        
        guard let userInfo = notification.userInfo,
            let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        delegateTextField?.passObjectToMove(insets: contentInset, variableInt: self.variableInt)
    }
    
    //step.4 Method to reset view/scrollview when keyboard is hidden.
    @objc func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        
        delegateTextField?.passObjectToMove(insets: UIEdgeInsets.zero, variableInt: self.variableInt)
    }
    
    //step.5 Method to remove observers
    public func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
}


