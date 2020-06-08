//
//  LoadingCustom.swift
//  CustomToolsDGP
//
//  Created by David Galán on 17/11/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

var loadingActived = false

extension UIViewController {
    
    public func loadingON(typeLoading: LoadingCustomTools.LoadingCustomType = .standard, text: String? = nil, textColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), textSize: CGFloat = 14, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil, customImage: UIImage? = nil) {
        DispatchQueue.main.async {
            if !loadingActived {
                loadingActived = true
                self.view.isUserInteractionEnabled = false
                LoadingCustomTools.customWait(typeLoading: typeLoading, text: text, textColor: textColor, textSize: textSize, borderWidth: borderWidth, borderColor: borderColor, customImage: customImage)
            }
        }
    }
    
    public func loadingUpdateText(text: String) {
        DispatchQueue.main.async {
            if LoadingCustomTools.textLabel?.text != nil {
                LoadingCustomTools.textLabel?.text = text
            }
        }
    }
    
    public func loadingOFF() {
        DispatchQueue.main.async {
            loadingActived = false
            self.view.isUserInteractionEnabled = true
            LoadingCustomTools.clear()
        }
    }
    
}


public class LoadingCustomTools: NSObject {
    
    public enum LoadingCustomType {
        case standard
        case pulse
    }
    
    // Shared objets
    static let window: UIView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
    static var mainViewContainer: UIView?
    static var textLabel: UILabel?

    // Standard objects
    static var viewContainer: UIView?
    static var stackView: UIStackView?
    static var indicator: UIActivityIndicatorView?
    
    // Pulse objects
    static let animatableLayer = CAShapeLayer()
    static let animationView = UIView()
    static var imageIcon: UIImageView?
    
    static func clear() {
        mainViewContainer?.removeFromSuperview()
    }
    
    static func customWait(typeLoading: LoadingCustomType, text: String?, textColor: UIColor, textSize: CGFloat, borderWidth: CGFloat?, borderColor: UIColor?, customImage: UIImage?) {
        
        // MARK: MAIN VIEW CONTAINER
        mainViewContainer = UIView()
        mainViewContainer?.clipsToBounds = true
        mainViewContainer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        mainViewContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        window.addSubview(mainViewContainer!)
        window.bringSubviewToFront(mainViewContainer!)

        mainViewContainer?.widthAnchor.constraint(equalToConstant: window.bounds.width).isActive = true
        mainViewContainer?.heightAnchor.constraint(equalToConstant: window.bounds.height).isActive = true
        mainViewContainer?.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        mainViewContainer?.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        
        // MARK: SWITCH ANIMATION
        switch typeLoading {
        case .standard:
            LoadingCustomTools.setStandardLoading(text: text, textColor: textColor, textSize: textSize, borderWidth: borderWidth, borderColor: borderColor)
            break
        case .pulse:
            LoadingCustomTools.setPulseLoading(text: text, textColor: textColor, textSize: textSize, customImage: customImage)
            break
        }
    }
    
}

