//
//  ImageAlertTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 15/10/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class ImageAlertTool {
    
    public enum GestureOptions {
        case none
        case zoom
        case rotate
        case zoomAndRotate
    }
    
    // MARK: OBJECTS
    var mainViewContainer: UIView!
    
    var imageViewScale: CGFloat = 1.0
    let maxScale: CGFloat = 100.0
    let minScale: CGFloat = 1.0

    
    // MARK: START METHODS
    public init() {
    }
    
    
    public func loadImageAsync(url: String, gestureOptions: GestureOptions, completion: @escaping (Bool) -> ()) {
        
        if url == "" {
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                if let imageData = UIImage(data: data!) {
                    self.loadImageActions(image: imageData, gestureOptions: gestureOptions) { (success) in
                        completion(success)
                    }
                } else {
                    completion(false)
                    return
                }
            }
        }).resume()
    }
    
    public func loadImageFromAssets(image: UIImage?, gestureOptions: GestureOptions, completion: @escaping (Bool) -> ()) {
        
        guard image != nil else {
            completion(false)
            return
        }
        
        DispatchQueue.main.async {
            self.loadImageActions(image: image!, gestureOptions: gestureOptions) { (success) in
                completion(success)
            }
        }
    }
    
    private func loadImageActions(image: UIImage, gestureOptions: GestureOptions, completion: @escaping (Bool) -> ()) {
        
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
        
        // Add items to containers
        self.mainViewContainer.addSubview(buttonMainContainer)
        self.mainViewContainer.addSubview(imageToLoad)
        
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
        
        if gestureOptions != .none {
            setupGestureOptions(image: imageToLoad, gestureOptions: gestureOptions)
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
    
    // SETUP GESTURE OPTIONS
    private func setupGestureOptions(image: UIImageView, gestureOptions: GestureOptions) {
        
        var pinchGesture: UIPinchGestureRecognizer?
        var rotationGesture: UIRotationGestureRecognizer?
        
        switch gestureOptions {
        case .none:
            break
        case .zoom:
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureCustom(_:)))
        case .rotate:
            rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureCustom(_:)))
        case .zoomAndRotate:
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureCustom(_:)))
            rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureCustom(_:)))
        }
        
        pinchGesture?.delegate = self as? UIGestureRecognizerDelegate
        rotationGesture?.delegate = self as? UIGestureRecognizerDelegate
        
        image.isUserInteractionEnabled = true
        
        if pinchGesture != nil {
            image.addGestureRecognizer(pinchGesture!)
        }
        
        if rotationGesture != nil {
            image.addGestureRecognizer(rotationGesture!)
        }
    }
    
    @objc private func pinchGestureCustom(_ recognizer: UIPinchGestureRecognizer) {
        
        guard let recognizerView = recognizer.view else {
            return
        }
        
        if recognizer.state == .began || recognizer.state == .changed {
            let pinchScale: CGFloat = recognizer.scale
            
            if imageViewScale * pinchScale < maxScale && imageViewScale * pinchScale > minScale {
                imageViewScale *= pinchScale
                recognizerView.transform = (recognizerView.transform.scaledBy(x: pinchScale, y: pinchScale))
            }
            recognizer.scale = 1.0
        }
    }
    
    @objc private func rotationGestureCustom(_ recognizer: UIRotationGestureRecognizer) {
        
        guard let recognizerView = recognizer.view else {
            return
        }
        
        recognizerView.transform = recognizerView.transform.rotated(by: recognizer.rotation)
        recognizer.rotation = 0
    }
    
    
    // BUTTON ACTION METHODS
    @objc func buttonMainContainerAction() {
        print("ImageAlertTool: buttonMainContainerAction")
        mainViewContainer.removeFromSuperview()
    }
    
}
