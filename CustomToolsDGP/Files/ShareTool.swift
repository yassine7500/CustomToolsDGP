//
//  ShareTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 08/08/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class ShareTool {
    
    public init() {
        
    }
    
    public func shareApp(textToShare: String, viewController: UIViewController) {
        
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = viewController.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        // activityViewController.excludedActivityTypes = [ UIActivityType.airDrop ]
        
        // present the view controller
        viewController.present(activityViewController, animated: true, completion: nil)
    }
    
}
