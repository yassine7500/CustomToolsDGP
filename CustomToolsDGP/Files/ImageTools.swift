//
//  ImageTools.swift
//  CustomToolsDGP
//
//  Created by David SG on 16/02/2020.
//  Copyright © 2020 David Galán. All rights reserved.
//

import AVKit

public class ImageTools {
    
    public enum GestureOptions {
        case none
        case zoom
        case rotate
        case pan
        case panAndRotate
        case zoomAndPan
        case zoomAndRotate
        case zoomAndRotateAndPan
    }
    
    // MARK: PARAMETERS
    var panGesture: UIPanGestureRecognizer?
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
        
        switch gestureOptions {
        case .none:
            break
        case .zoom:
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureCustom(_:)))
        case .rotate:
            rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureCustom(_:)))
        case .pan:
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureCustom(_:)))
        case .panAndRotate:
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureCustom(_:)))
            rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureCustom(_:)))
        case .zoomAndRotate:
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureCustom(_:)))
            rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureCustom(_:)))
        case .zoomAndPan:
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureCustom(_:)))
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureCustom(_:)))
        case .zoomAndRotateAndPan:
            pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGestureCustom(_:)))
            rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(rotationGestureCustom(_:)))
            panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureCustom(_:)))
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
        
        if panGesture != nil {
            image.addGestureRecognizer(panGesture!)
        }
    }
    
    @objc private func panGestureCustom(_ recognizer: UIPanGestureRecognizer) {
        
        guard let recognizerView = recognizer.view else {
            return
        }
        
        if recognizer.state == .began || recognizer.state == .changed {
            
            let translation = recognizer.translation(in: recognizerView)
            recognizer.view!.center = CGPoint(x: recognizerView.center.x + translation.x, y: recognizerView.center.y + translation.y)
            recognizer.setTranslation(.zero, in: recognizerView)
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
    
    public func getThumbnailOfVideoFromRemoteUrl(url: String, width: CGFloat, height: CGFloat, completion: @escaping (UIImage?) -> ()) {
        
        if let urlValue = URL(string: url) {
            
            DispatchQueue.main.async {
                let asset = AVAsset(url: urlValue)
                let assetImgGenerate = AVAssetImageGenerator(asset: asset)
                assetImgGenerate.appliesPreferredTrackTransform = true
                assetImgGenerate.maximumSize = CGSize(width: width, height: height)
                let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
                
                do {
                    let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
                    let thumbnail = UIImage(cgImage: img)
                    completion(thumbnail)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
        
        
    }
    
    
}
 

extension UIView {

    public func asImage() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: bounds)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
            defer { UIGraphicsEndImageContext() }
            guard let currentContext = UIGraphicsGetCurrentContext() else {
                return nil
            }
            self.layer.render(in: currentContext)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    }
}
