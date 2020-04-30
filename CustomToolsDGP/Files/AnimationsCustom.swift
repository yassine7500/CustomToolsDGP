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
    public func animationScalePopup(viewMainContainer: UIView, viewContainerAnimated: UIView, outAction: Bool = false, withDuration: TimeInterval = 0.4, delay: TimeInterval = 0, usingSpringWithDamping: CGFloat = 0.8, initialSpringVelocity: CGFloat = 8, options: UIView.AnimationOptions = [.curveEaseInOut], _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        if outAction {
            viewMainContainer.alpha = 1
            viewContainerAnimated.transform = CGAffineTransform(scaleX: 1, y: 1)
        } else {
            viewMainContainer.alpha = 0
            viewContainerAnimated.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
        }
        
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animations: {
            
            if outAction {
                viewMainContainer.alpha = 0
                viewContainerAnimated.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            } else {
                viewMainContainer.alpha = 1
                viewContainerAnimated.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            
            self.delegate?.view.layoutIfNeeded()
        }, completion: { _ in
            
            completionAction = action
            
            if let actions = completionAction {
                actions()
            }
        })
    }
    
    public func animationAppearFromBottom(viewMainContainer: UIView, viewContainerAnimated: UIView, outAction: Bool = false, withDuration: TimeInterval = 0.4, delay: TimeInterval = 0, usingSpringWithDamping: CGFloat = 0.6, initialSpringVelocity: CGFloat = 1, options: UIView.AnimationOptions = [.curveEaseInOut], _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        if outAction {
            viewMainContainer.alpha = 1
            viewContainerAnimated.transform = CGAffineTransform(translationX: 0, y: 0)
        } else {
            viewMainContainer.alpha = 0
            viewContainerAnimated.transform = CGAffineTransform(translationX: 0, y: 100)
        }
        
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: withDuration, delay: delay, usingSpringWithDamping: usingSpringWithDamping, initialSpringVelocity: initialSpringVelocity, options: options, animations: {
            
            if outAction {
                viewMainContainer.alpha = 0
                viewContainerAnimated.transform = CGAffineTransform(translationX: 0, y: 100)
            } else {
                viewMainContainer.alpha = 1
                viewContainerAnimated.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            
            self.delegate?.view.layoutIfNeeded()
            
        }, completion: { _ in
            
            completionAction = action
            
            if let actions = completionAction {
                actions()
            }
        })
    }
    
    public func disolveView(viewContainer: UIView, outAction: Bool = false, withDuration: TimeInterval = 0.4, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        if outAction {
            viewContainer.alpha = 0
        } else {
            viewContainer.alpha = 1
        }
        
        delegate?.view.layoutIfNeeded()
        
        UIView.animate(withDuration: withDuration, animations: {
            
            if outAction {
                viewContainer.alpha = 1
            } else {
                viewContainer.alpha = 0
            }
            
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
    
    public func createSelectedViewAnimation(isCellSelected: Bool, viewContainer: UIView?, withDuration: TimeInterval = 0.05, _ action: @escaping ()->Void) {
        
        var completionAction: ( ()->Void )?
        
        var valueAnimation: CGFloat = 1.0
        isCellSelected == true ? (valueAnimation = 0.95) : (valueAnimation = 1.0)
        
        UIView.animate(withDuration: withDuration, animations: {
            viewContainer?.transform = CGAffineTransform(scaleX: valueAnimation, y: valueAnimation)
        }, completion: { _ in
            
            completionAction = action
            
            if let actions = completionAction {
                actions()
            }
        })
    }
    
}
