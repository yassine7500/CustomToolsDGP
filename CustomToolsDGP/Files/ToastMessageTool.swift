//
//  ToastMessageTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 30/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class ToastMessage {
    
    public func toast(delegate: UIView, message: String, timeStamp: Double = 3.0, backgroundColor: UIColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1), borderColor: UIColor = #colorLiteral(red: 0.1604149618, green: 0.1736847846, blue: 0.192962541, alpha: 1), textColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), customImage: UIImage?, position: Int = 1, fontSize: CGFloat = 14, borderWidth: CGFloat = 3) {
        
        // Parameters
        let window = UIApplication.shared.keyWindow
        let windowWidth = window?.bounds.width ?? 0
        let marginWidth: CGFloat = 32.0
        let stackViewSpacing: CGFloat = 16.0
        
        // View Container
        let viewContainer = UIView()
        viewContainer.layer.cornerRadius = 6
        viewContainer.clipsToBounds = true
        viewContainer.layer.borderWidth = borderWidth
        viewContainer.widthAnchor.constraint(equalToConstant: windowWidth - marginWidth).isActive = true
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        // Stack View
        let stackView = UIStackView()
        stackView.backgroundColor = .white
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.fillProportionally
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = stackViewSpacing
        stackView.clipsToBounds = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Image
        let imageIcon = UIImageView()
        imageIcon.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        imageIcon.widthAnchor.constraint(equalToConstant: 30.0).isActive = true
        imageIcon.clipsToBounds = true
        imageIcon.contentMode = .scaleAspectFit
        
        // Label
        let textLabel = UILabel()
        textLabel.font = textLabel.font.withSize(fontSize)
        textLabel.text = message
        textLabel.textAlignment = .justified
        textLabel.numberOfLines = 0
        
        // Variable parameters
        viewContainer.layer.borderColor = borderColor.cgColor
        viewContainer.backgroundColor = backgroundColor
        textLabel.textColor = textColor
        if customImage != nil {
            imageIcon.image = customImage
        } else {
            imageIcon.isHidden = true
        }
        
        // Add items to stackView
        stackView.addArrangedSubview(imageIcon)
        stackView.addArrangedSubview(textLabel)
        
        // Add items to viewContainner
        viewContainer.addSubview(stackView)
        
        // Add item to screen
        viewContainer.alpha = 0.0
        window?.addSubview(viewContainer)
        window?.bringSubviewToFront(viewContainer)
        
        // Add constraints
        switch position {
        case 1: // top
            viewContainer.topAnchor.constraint(greaterThanOrEqualTo: delegate.topAnchor, constant: 20).isActive = true
            break
        case 3: // bottom
            viewContainer.bottomAnchor.constraint(greaterThanOrEqualTo: delegate.bottomAnchor, constant: -20).isActive = true
            break
        default: // center
            viewContainer.centerYAnchor.constraint(equalTo: delegate.centerYAnchor).isActive = true
            break
        }
        
        viewContainer.centerXAnchor.constraint(equalTo: delegate.centerXAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -16).isActive = true
        stackView.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -20).isActive = true
        
        // Create animation
        UIView.animate(withDuration: 0.5, animations: {
            viewContainer.alpha = 1.0
        }, completion: {
            (finished: Bool) -> Void in
            
            UIView.animate(withDuration: 0.5, delay: timeStamp, animations: {
                viewContainer.alpha = 0.0
            }, completion: {
                (finished: Bool) -> Void in
                viewContainer.removeFromSuperview()
            })
        })
        
    }
}


