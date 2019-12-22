//
//  LoadingCustomStandard.swift
//  CustomToolsDGP
//
//  Created by David SG on 22/12/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

extension LoadingCustomTools {
    
    // MARK: SET STANDARD LOADING
    static func setStandardLoading(text: String?, textColor: UIColor, textSize: CGFloat, borderWidth: CGFloat?, borderColor: UIColor?) {
        
        // MARK: VIEW CONTAINER
        viewContainer = UIView()
        viewContainer?.layer.cornerRadius = 16
        viewContainer?.clipsToBounds = true
        if borderWidth != nil && borderColor != nil {
            viewContainer?.layer.borderWidth = borderWidth!
            viewContainer?.layer.borderColor = borderColor?.cgColor
        }
        viewContainer?.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        
        viewContainer?.translatesAutoresizingMaskIntoConstraints = false
        mainViewContainer?.addSubview(viewContainer!)
        
        viewContainer?.topAnchor.constraint(greaterThanOrEqualTo: mainViewContainer!.topAnchor, constant: 50).isActive = true
        viewContainer?.bottomAnchor.constraint(lessThanOrEqualTo: mainViewContainer!.bottomAnchor, constant: 50).isActive = true
        viewContainer?.leadingAnchor.constraint(greaterThanOrEqualTo: mainViewContainer!.leadingAnchor, constant: 30).isActive = true
        viewContainer?.trailingAnchor.constraint(lessThanOrEqualTo: mainViewContainer!.trailingAnchor, constant: 30).isActive = true
        viewContainer?.centerYAnchor.constraint(equalTo: mainViewContainer!.centerYAnchor).isActive = true
        viewContainer?.centerXAnchor.constraint(equalTo: mainViewContainer!.centerXAnchor).isActive = true
                
        // MARK: STACK VIEW
        stackView = UIStackView()
        stackView?.axis = NSLayoutConstraint.Axis.vertical
        stackView?.distribution = UIStackView.Distribution.fill
        stackView?.alignment = UIStackView.Alignment.center
        stackView?.spacing = 20
        stackView?.clipsToBounds = true
        
        stackView?.translatesAutoresizingMaskIntoConstraints = false
        viewContainer?.addSubview(stackView!)
        
        stackView?.topAnchor.constraint(equalTo: viewContainer!.topAnchor, constant: 20).isActive = true
        stackView?.bottomAnchor.constraint(equalTo: viewContainer!.bottomAnchor, constant: -20).isActive = true
        stackView?.leadingAnchor.constraint(equalTo: viewContainer!.leadingAnchor, constant: 20).isActive = true
        stackView?.trailingAnchor.constraint(equalTo: viewContainer!.trailingAnchor, constant: -20).isActive = true
        
        // MARK: INDICATOR
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        } else {
            // Fallback on earlier versions
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        indicator?.color = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        indicator?.frame = .zero
        indicator?.startAnimating()
        
        indicator?.translatesAutoresizingMaskIntoConstraints = false
        stackView?.addArrangedSubview(indicator!)
        
        indicator?.widthAnchor.constraint(equalToConstant: 30).isActive = true
        indicator?.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // MARK: LABEL
        if text != nil {
            // Label
            textLabel = UILabel()
            textLabel?.font = UIFont.systemFont(ofSize: textSize, weight: .regular)
            textLabel?.text = text
            textLabel?.textAlignment = .center
            textLabel?.numberOfLines = 0
            textLabel?.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            textLabel?.adjustsFontSizeToFitWidth = true
            textLabel?.minimumScaleFactor = 0.5
            
            textLabel?.translatesAutoresizingMaskIntoConstraints = false
            stackView?.addArrangedSubview(textLabel!)
            
            textLabel?.leadingAnchor.constraint(greaterThanOrEqualTo: stackView!.leadingAnchor, constant: 0).isActive = true
            textLabel?.trailingAnchor.constraint(lessThanOrEqualTo: stackView!.trailingAnchor, constant: 0).isActive = true
            textLabel?.centerXAnchor.constraint(equalTo: viewContainer!.centerXAnchor).isActive = true
        }
    }
    
}

