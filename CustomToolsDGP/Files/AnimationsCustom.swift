//
//  AnimationsCustom.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UIKit

public class AnimationsCustom {
    
    private var delegate: UIViewController?
    
    public init(delegate: UIViewController) {
        self.delegate = delegate
    }
    
    // Standard animation for init popup.
    func animationScalePopup(viewContainer: UIView, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        viewContainer.alpha = 0
        viewContainer.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8, options: [.curveEaseInOut], animations: {
            viewContainer.alpha = 1
            viewContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.delegate?.view.layoutIfNeeded()
        }, completion: { _ in
            
            completionAction = action
            
            if let actions = completionAction {
                actions()
            }
        })
    }
    
    func animationAppearFromBottom(viewContainer: UIView, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        viewContainer.alpha = 0
        viewContainer.transform = CGAffineTransform(translationX: 0, y: 100)
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
            viewContainer.alpha = 1
            viewContainer.transform = CGAffineTransform(translationX: 0, y: 0)
            self.delegate?.view.layoutIfNeeded()
        }, completion: { _ in
            
            completionAction = action
            
            if let actions = completionAction {
                actions()
            }
        })
    }
    
}
