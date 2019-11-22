//
//  LoadingCustom.swift
//  CustomToolsDGP
//
//  Created by David Galán on 17/11/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

var loadingActived = false

extension UIViewController {
    
    public func loadingON(text: String? = nil, borderWidth: CGFloat? = nil, borderColor: UIColor? = nil) {
        if !loadingActived {
            loadingActived = true
            self.view.isUserInteractionEnabled = false
            LoadingCustomTools.customWait(text: text, borderWidth: borderWidth, borderColor: borderColor)
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
    
    public func setContainerBackground(color: UIColor) {
        DispatchQueue.main.async {
            LoadingCustomTools.viewContainer?.backgroundColor = color
        }
    }
    
}


public class LoadingCustomTools: NSObject {
    
    static let window: UIView = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!
    static var mainViewContainer: UIView?
    static var viewContainer: UIView?
    static var stackView: UIStackView?
    static var indicator: UIActivityIndicatorView?
    static var textLabel: UILabel?
    
    static func clear() {
        mainViewContainer?.removeFromSuperview()
    }
    
    static func customWait(text: String?, borderWidth: CGFloat?, borderColor: UIColor?) {
        
        // View Container Main
        mainViewContainer = UIView()
        mainViewContainer?.clipsToBounds = true
        mainViewContainer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        mainViewContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        // View Container
        viewContainer = UIView()
        viewContainer?.layer.cornerRadius = 10
        viewContainer?.clipsToBounds = true
        if borderWidth != nil && borderColor != nil {
            viewContainer?.layer.borderWidth = borderWidth!
            viewContainer?.layer.borderColor = borderColor?.cgColor
        }
        viewContainer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        viewContainer?.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        stackView = UIStackView()
        stackView?.axis = NSLayoutConstraint.Axis.vertical
        stackView?.distribution = UIStackView.Distribution.fill
        stackView?.alignment = UIStackView.Alignment.center
        stackView?.spacing = 20
        stackView?.clipsToBounds = true
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        
        // Indicator
        indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        indicator?.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        indicator?.frame = .zero
        indicator?.startAnimating()
        indicator?.translatesAutoresizingMaskIntoConstraints = false
        
        if text != nil {
            // Label
            textLabel = UILabel()
            textLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            textLabel?.text = text
            textLabel?.textAlignment = .center
            textLabel?.numberOfLines = 0
            textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textLabel?.adjustsFontSizeToFitWidth = true
            textLabel?.minimumScaleFactor = 0.5
            textLabel?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // Add items to stackView
        stackView?.addArrangedSubview(indicator!)
        if text != nil {
            stackView?.addArrangedSubview(textLabel!)
        }
        
        // Add items to containers
        viewContainer?.addSubview(stackView!)
        mainViewContainer?.addSubview(viewContainer!)
        
        // Add item to screen
        window.addSubview(mainViewContainer!)
        window.bringSubviewToFront(mainViewContainer!)
        
        // Add constraints
        mainViewContainer?.widthAnchor.constraint(equalToConstant: window.bounds.width).isActive = true
        mainViewContainer?.heightAnchor.constraint(equalToConstant: window.bounds.height).isActive = true
        mainViewContainer?.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        mainViewContainer?.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        
        viewContainer?.topAnchor.constraint(greaterThanOrEqualTo: mainViewContainer!.topAnchor, constant: 50).isActive = true
        viewContainer?.bottomAnchor.constraint(lessThanOrEqualTo: mainViewContainer!.bottomAnchor, constant: 50).isActive = true
        viewContainer?.leadingAnchor.constraint(greaterThanOrEqualTo: mainViewContainer!.leadingAnchor, constant: 30).isActive = true
        viewContainer?.trailingAnchor.constraint(lessThanOrEqualTo: mainViewContainer!.trailingAnchor, constant: 30).isActive = true
        viewContainer?.centerYAnchor.constraint(equalTo: mainViewContainer!.centerYAnchor).isActive = true
        viewContainer?.centerXAnchor.constraint(equalTo: mainViewContainer!.centerXAnchor).isActive = true
        
        stackView?.topAnchor.constraint(equalTo: viewContainer!.topAnchor, constant: 20).isActive = true
        stackView?.bottomAnchor.constraint(equalTo: viewContainer!.bottomAnchor, constant: -20).isActive = true
        stackView?.leadingAnchor.constraint(equalTo: viewContainer!.leadingAnchor, constant: 20).isActive = true
        stackView?.trailingAnchor.constraint(equalTo: viewContainer!.trailingAnchor, constant: -20).isActive = true
       
        indicator?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        indicator?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        if text != nil {
            textLabel?.leadingAnchor.constraint(greaterThanOrEqualTo: stackView!.leadingAnchor, constant: 0).isActive = true
            textLabel?.trailingAnchor.constraint(lessThanOrEqualTo: stackView!.trailingAnchor, constant: 0).isActive = true
            textLabel?.centerXAnchor.constraint(equalTo: viewContainer!.centerXAnchor).isActive = true
        }
    }
}
