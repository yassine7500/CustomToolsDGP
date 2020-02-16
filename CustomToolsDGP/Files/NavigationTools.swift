//
//  NavigationTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


public func getNewViewController(storyBoardName: String, viewIdentifier: String) -> UIViewController {
    let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: viewIdentifier)
}

extension UIViewController {
    
    public func disableSwipeBackGesture(enabled: Bool) {
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enabled
    }
    
    public func goToPreviousView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    public func goBackToRootView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    public func openPopupView(viewController: UIViewController, alphaBlackComponent: CGFloat?) {
        if alphaBlackComponent != nil {
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(alphaBlackComponent!)
        }
        self.addChild(viewController)
        self.view.addSubview(viewController.view)
    }
    
    public func openPopupViewInFrontNavigation(viewController: UIViewController, alphaBlackComponent: CGFloat?) {
        if alphaBlackComponent != nil {
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(alphaBlackComponent!)
        }
        self.navigationController?.addChild(viewController)
        self.navigationController?.view.addSubview(viewController.view)
    }
    
    public func openPopupViewInFrontTabBar(viewController: UIViewController, alphaBlackComponent: CGFloat?) {
        if alphaBlackComponent != nil {
            viewController.view.backgroundColor = UIColor.black.withAlphaComponent(alphaBlackComponent!)
        }
        self.tabBarController?.addChild(viewController)
        self.tabBarController?.view.addSubview(viewController.view)
    }
    
    public func openPopupView(storyBoardName: String, viewIdentifier: String, alphaBlackComponent: CGFloat?) {
        
        let storyboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: viewIdentifier)
        
        if alphaBlackComponent != nil {
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(alphaBlackComponent!)
        }
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
    }
    
    public func openVieWithConstraintsStandard(customView: UIViewController) {
        
        self.openPopupView(viewController: customView, alphaBlackComponent: 0.0)
        
        customView.view.translatesAutoresizingMaskIntoConstraints = false
        customView.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        customView.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        customView.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        customView.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    public func closePopupView() {
        self.removeFromParent()
        self.view.removeFromSuperview()
    }
    
}
