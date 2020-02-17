//
//  ImageTools.swift
//  CustomToolsDGP
//
//  Created by David SG on 16/02/2020.
//  Copyright © 2020 David Galán. All rights reserved.
//

public class ImageTools {
    
    public enum GestureOptions {
        case none
        case zoom
        case rotate
        case zoomAndRotate
    }
    
    // MARK: PARAMETERS
    var pinchGesture: UIPinchGestureRecognizer?
    var rotationGesture: UIRotationGestureRecognizer?
    var imageViewScale: CGFloat = 1.0
    let maxScale: CGFloat = 100.0
    let minScale: CGFloat = 1.0
    
    
    // MARK: START METHOD
    public init() {
    }
    
    // MARK: SETUP METHOD
    public func setupGestureOptions(image: UIImageView, gestureOptions: GestureOptions) {
        
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
    
    
    public func getRatioCustom(ratioW: CGFloat, ratioH: CGFloat, width: CGFloat?, height: CGFloat?) -> CGFloat? {
    
        guard width != nil || height != nil else {
            return nil
        }
        
        if width == nil {
            
            let result: CGFloat = (height! * ratioW) / ratioH
            return result
            
        } else if height == nil {
            
            let result: CGFloat = (width! * ratioH) / ratioW
            return result
            
        } else {
            return nil
        }
    }
    
    
    
}
 

