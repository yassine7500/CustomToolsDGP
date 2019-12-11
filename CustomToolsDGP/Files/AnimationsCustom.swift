//
//  AnimationsCustom.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


public class AnimationsCustom {
    
    private var delegate: UIViewController?
    
    public init() {
    }
    
    public init(delegate: UIViewController) {
        self.delegate = delegate
    }
    
    // Standard animation for init popup.
    public func animationScalePopup(viewContainer: UIView, withDuration: TimeInterval = 0.4, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        viewContainer.alpha = 0
        viewContainer.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: withDuration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 8, options: [.curveEaseInOut], animations: {
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
    
    public func animationAppearFromBottom(viewContainer: UIView, withDuration: TimeInterval = 0.4, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        viewContainer.alpha = 0
        viewContainer.transform = CGAffineTransform(translationX: 0, y: 100)
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: withDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: [.curveEaseOut], animations: {
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
    
    public func disolveView(viewContainer: UIView, withDuration: TimeInterval = 0.4, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        viewContainer.alpha = 1
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: withDuration, animations: {
            viewContainer.alpha = 0
            self.delegate?.view.layoutIfNeeded()
        }, completion: { _ in
            
            completionAction = action
            
            if let actions = completionAction {
                actions()
            }
        })
    }
    
    public func createSelectedCellAnimation(isCellSelected: Bool, tableView: UITableView, cellViewContainer: UIView?, indexPath: IndexPath, withDuration: TimeInterval = 0.05) {
                
        var valueAnimation: CGFloat = 1.0
        isCellSelected == true ? (valueAnimation = 0.95) : (valueAnimation = 1.0)
        
        UIView.animate(withDuration: withDuration, animations: {
            cellViewContainer?.transform = CGAffineTransform(scaleX: valueAnimation, y: valueAnimation)
        })
    }
    
}
