//
//  SegueTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//
//

extension UIViewController {
    
    /**
     Checks whether controller can perform specific segue or not.
     - parameter identifier: Identifier of UIStoryboardSegue.
     */
    public func canPerformSegue(withIdentifier identifier: String) -> Bool {
        //first fetch segue templates set in storyboard.
        guard let identifiers = value(forKey: "storyboardSegueTemplates") as? [NSObject] else {
            //if cannot fetch, return false
            return false
        }
        //check every object in segue templates, if it has a value for key _identifier equals your identifier.
        let canPerform = identifiers.contains { (object) -> Bool in
            if let id = object.value(forKey: "_identifier") as? String {
                if id == identifier {
                    return true
                } else {
                    return false
                }
            } else {
                return false
            }
        }
        return canPerform
    }
    
    public func performSegueCustom(withIdentifier identifier: String, sender: Any? = nil) {
        if canPerformSegue(withIdentifier: identifier) {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: identifier, sender: sender)
            }
        }
    }
}
