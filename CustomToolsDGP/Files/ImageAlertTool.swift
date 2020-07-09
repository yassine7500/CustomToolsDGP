//
//  ImageAlertTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 15/10/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UIKit

public var isImageAlertToolOpened = false

public class ImageAlertTool {
    
    // MARK: OBJECTS
    var mainViewContainer: UIView!
    public var buttonCloseInFront: UIButton!
    
    var imageTools: ImageTools?
    var imageViewScale: CGFloat = 1.0
    let maxScale: CGFloat = 100.0
    let minScale: CGFloat = 1.0
    let buttonInFrontSize: CGFloat = 40.0

    
    // MARK: START METHODS
    public init() {
    }
    
    
    public func loadImageAsync(url: String, gestureOptions: ImageTools.GestureOptions, completion: @escaping (Bool) -> ()) {
        
        guard !isImageAlertToolOpened else { return }
        isImageAlertToolOpened = true
        
        if url == "" {
            isImageAlertToolOpened = false
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                isImageAlertToolOpened = false
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                if let imageData = UIImage(data: data!) {
                    self.loadImageActions(image: imageData, gestureOptions: gestureOptions) { (success) in
                        isImageAlertToolOpened = false
                        completion(success)
                    }
                } else {
                    isImageAlertToolOpened = false
                    completion(false)
                    return
                }
            }
        }).resume()
    }
    
    public func loadImageFromAssets(image: UIImage?, gestureOptions: ImageTools.GestureOptions, completion: @escaping (Bool) -> ()) {
        
        guard !isImageAlertToolOpened else { return }
        isImageAlertToolOpened = true
        
        guard image != nil else {
            isImageAlertToolOpened = false
            completion(false)
            return
        }
        
        DispatchQueue.main.async {
            self.loadImageActions(image: image!, gestureOptions: gestureOptions) { (success) in
                isImageAlertToolOpened = false
                completion(success)
            }
        }
    }
    
    private func loadImageActions(image: UIImage, gestureOptions: ImageTools.GestureOptions, completion: @escaping (Bool) -> ()) {
        
        let window = UIApplication.shared.keyWindow
        
        // View Container Main
        self.mainViewContainer = UIView()
        self.mainViewContainer.clipsToBounds = true
        self.mainViewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        self.mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Button Container Main
        let buttonMainContainer = UIButton()
        buttonMainContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        buttonMainContainer.addTarget(self, action: #selector(self.buttonMainContainerAction), for: .touchUpInside)
        buttonMainContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Image
        let imageToLoad = UIImageView()
        imageToLoad.clipsToBounds = true
        imageToLoad.layer.cornerRadius = 2
        imageToLoad.contentMode = .scaleAspectFit
        imageToLoad.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        imageToLoad.image = image
        imageToLoad.translatesAutoresizingMaskIntoConstraints = false
        
        // Button Close in Front
        buttonCloseInFront = UIButton()
        buttonCloseInFront.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.75)
        buttonCloseInFront.clipsToBounds = true
        buttonCloseInFront.layer.cornerRadius = buttonInFrontSize/2
        buttonCloseInFront.setTitleColor(.black, for: .normal)
        if #available(iOS 13.0, *) {
            let config = UIImage.SymbolConfiguration(pointSize: 25, weight: .medium, scale: .small)
            buttonCloseInFront.setImage(UIImage(systemName: "xmark", withConfiguration: config), for: .normal)
        } else {
            buttonCloseInFront.setTitle("X", for: .normal)
        }
        buttonCloseInFront.addTarget(self, action: #selector(self.buttonMainContainerAction), for: .touchUpInside)
        buttonCloseInFront.translatesAutoresizingMaskIntoConstraints = false
        
        // Add items to containers
        self.mainViewContainer.addSubview(buttonMainContainer)
        self.mainViewContainer.addSubview(imageToLoad)
        self.mainViewContainer.addSubview(buttonCloseInFront)
        
        DispatchQueue.main.async {
            
            // Add item to screen
            window?.addSubview(self.mainViewContainer)
            window?.bringSubviewToFront(self.mainViewContainer)
            
            // Add constraints
            self.mainViewContainer.widthAnchor.constraint(equalToConstant: window!.bounds.width).isActive = true
            self.mainViewContainer.heightAnchor.constraint(equalToConstant: window!.bounds.height).isActive = true
            self.mainViewContainer.centerXAnchor.constraint(equalTo: window!.centerXAnchor).isActive = true
            self.mainViewContainer.centerYAnchor.constraint(equalTo: window!.centerYAnchor).isActive = true
            
            buttonMainContainer.topAnchor.constraint(equalTo: self.mainViewContainer.topAnchor).isActive = true
            buttonMainContainer.bottomAnchor.constraint(equalTo: self.mainViewContainer.bottomAnchor).isActive = true
            buttonMainContainer.leadingAnchor.constraint(equalTo: self.mainViewContainer.leadingAnchor).isActive = true
            buttonMainContainer.trailingAnchor.constraint(equalTo: self.mainViewContainer.trailingAnchor).isActive = true
            
            imageToLoad.widthAnchor.constraint(equalToConstant: window!.bounds.width - 40).isActive = true
            imageToLoad.heightAnchor.constraint(equalToConstant: window!.bounds.width - 40).isActive = true
            imageToLoad.centerYAnchor.constraint(equalTo: self.mainViewContainer.centerYAnchor).isActive = true
            imageToLoad.centerXAnchor.constraint(equalTo: self.mainViewContainer.centerXAnchor).isActive = true
            
            self.buttonCloseInFront.topAnchor.constraint(equalTo: self.mainViewContainer.topAnchor, constant: 14).isActive = true
            self.buttonCloseInFront.trailingAnchor.constraint(equalTo: self.mainViewContainer.trailingAnchor, constant: -14).isActive = true
            self.buttonCloseInFront.widthAnchor.constraint(equalToConstant: self.buttonInFrontSize).isActive = true
            self.buttonCloseInFront.heightAnchor.constraint(equalToConstant: self.buttonInFrontSize).isActive = true
            
            if gestureOptions != .none {
                self.imageTools = ImageTools()
                self.imageTools?.setupGestureOptions(image: imageToLoad, gestureOptions: gestureOptions)
            }
            
            // Create animation
            imageToLoad.alpha = 0
            imageToLoad.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
            self.mainViewContainer.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [.curveEaseOut], animations: {
                imageToLoad.alpha = 1
                imageToLoad.transform = CGAffineTransform(scaleX: 1, y: 1)
                self.mainViewContainer.layoutIfNeeded()
            }, completion: { _ in
                print(" 🌇 [ImageAlertTool] Image successfully loaded.")
                completion(true)
            })
        }
        
        
    }
    
    // BUTTON ACTION METHODS
    @objc func buttonMainContainerAction() {
        print("ImageAlertTool: buttonMainContainerAction")
        DispatchQueue.main.async {
            self.mainViewContainer.removeFromSuperview()
        }
    }
    
}

