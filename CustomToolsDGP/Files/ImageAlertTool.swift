//
//  ImageAlertTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 15/10/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


public class ImageAlertTool {
    
    // MARK: OBJECTS
    var mainViewContainer: UIView!
    var viewContainer: UIView!

    
    // MARK: START METHODS
    public init() {
    }
    
    
    public func openImage(url: String, containerRadius: CGFloat = 6, containerBackground: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), containerBorderWith: CGFloat = 2, containerBorderColor: UIColor = #colorLiteral(red: 0.1604149618, green: 0.1736847846, blue: 0.192962541, alpha: 1), completion: @escaping (Bool) -> ()) {
        
        if url == "" {
            completion(false)
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                completion(false)
            }
            
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: data!) {
                    print(" 🌇 [ImageAlertTool] Image successfully downloaded.")
                    
                    let window = UIApplication.shared.keyWindow
                    
                    // View Container Main
                    self.mainViewContainer = UIView()
                    self.mainViewContainer.clipsToBounds = true
                    self.mainViewContainer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
                    self.mainViewContainer.translatesAutoresizingMaskIntoConstraints = false
                    
                    // Button Container Main
                    let buttonMainContainer = UIButton()
                    buttonMainContainer.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 0)
                    buttonMainContainer.addTarget(self, action: #selector(self.buttonMainContainerAction), for: .touchUpInside)
                    buttonMainContainer.translatesAutoresizingMaskIntoConstraints = false
                    
                    // View Container
                    self.viewContainer = UIView()
                    self.viewContainer.layer.cornerRadius = containerRadius
                    self.viewContainer.clipsToBounds = true
                    self.viewContainer.backgroundColor = containerBackground
                    self.viewContainer.layer.borderWidth = containerBorderWith
                    self.viewContainer.layer.borderColor = containerBorderColor.cgColor
                    self.viewContainer.translatesAutoresizingMaskIntoConstraints = false
                    
                    // Image
                    let imageToLoad = UIImageView()
                    imageToLoad.clipsToBounds = true
                    imageToLoad.layer.cornerRadius = 2
                    imageToLoad.contentMode = .scaleAspectFit
                    imageToLoad.image = imageToCache
                    imageToLoad.translatesAutoresizingMaskIntoConstraints = false
                    
                    // Add items to containers
                    self.viewContainer.addSubview(imageToLoad)
                    self.mainViewContainer.addSubview(self.viewContainer)
                    self.mainViewContainer.addSubview(buttonMainContainer)
                    
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
                    
                    self.viewContainer.widthAnchor.constraint(equalToConstant: window!.bounds.width - 80).isActive = true
                    self.viewContainer.heightAnchor.constraint(equalToConstant: window!.bounds.width - 80).isActive = true
                    self.viewContainer.centerYAnchor.constraint(equalTo: self.mainViewContainer.centerYAnchor).isActive = true
                    self.viewContainer.centerXAnchor.constraint(equalTo: self.mainViewContainer.centerXAnchor).isActive = true
                    
                    imageToLoad.topAnchor.constraint(equalTo: self.viewContainer.topAnchor, constant: 30).isActive = true
                    imageToLoad.bottomAnchor.constraint(equalTo: self.viewContainer.bottomAnchor, constant: -30).isActive = true
                    imageToLoad.leadingAnchor.constraint(equalTo: self.viewContainer.leadingAnchor, constant: 30).isActive = true
                    imageToLoad.trailingAnchor.constraint(equalTo: self.viewContainer.trailingAnchor, constant: -30).isActive = true
                    
                    // Create animation
                    self.viewContainer.alpha = 0
                    self.viewContainer.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                    self.mainViewContainer.layoutIfNeeded()

                    UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 6, options: [.curveEaseOut], animations: {
                        self.viewContainer.alpha = 1
                        self.viewContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.mainViewContainer.layoutIfNeeded()
                    }, completion: { _ in
                        completion(true)
                    })
                }
            }
        }).resume()
    }

    
    // BUTTON ACTION METHODS
    @objc func buttonMainContainerAction() {
        print("ImageAlertTool: buttonMainContainerAction")
        mainViewContainer.removeFromSuperview()
    }
    
}
