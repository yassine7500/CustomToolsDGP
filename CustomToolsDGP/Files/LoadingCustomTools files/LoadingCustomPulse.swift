//
//  LoadingCustomPulse.swift
//  CustomToolsDGP
//
//  Created by David SG on 22/12/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

extension LoadingCustomTools {
    
    static func setPulseLoading(text: String?, textColor: UIColor, textSize: CGFloat, customImage: UIImage?) {
        
        // MARK: ANIMATION VIEW
        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        mainViewContainer?.addSubview(animationView)
        
        // Animation view constraints
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: mainViewContainer!.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: mainViewContainer!.centerYAnchor),
            animationView.widthAnchor.constraint(equalToConstant: 80.0),
            animationView.heightAnchor.constraint(equalToConstant: 80.0)
        ])
        
        // Others
        animationView.layoutIfNeeded()
        animationView.layer.cornerRadius = animationView.bounds.width / 2.0
        
        // MARK: ANIMATABLE LAYER
        animatableLayer.fillColor = animationView.backgroundColor?.cgColor
        animatableLayer.path = UIBezierPath(roundedRect: animationView.bounds, cornerRadius: animationView.layer.cornerRadius).cgPath
        animatableLayer.frame = animationView.bounds
        animatableLayer.cornerRadius = animationView.bounds.width / 2.0
        animatableLayer.masksToBounds = true
        
        // Add to view
        animationView.layer.addSublayer(animatableLayer)
        
        // Config animation
        let scale = CABasicAnimation(keyPath: "transform.scale")
        scale.fromValue = 1
        scale.toValue = 3
        scale.isAdditive = false
        
        let opacity = CABasicAnimation(keyPath: "opacity")
        opacity.fromValue = 1
        opacity.toValue = 0
        opacity.isAdditive = false
        
        let animation = CAAnimationGroup()
        animation.animations = [scale, opacity]
        animation.duration = 2.0
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = true
        animation.repeatCount = .infinity
        
        animatableLayer.add(animation, forKey: "growingAnimation")
        
        // MARK: LABEL
        if text != nil {
            // Label
            textLabel = UILabel()
            textLabel?.font = UIFont.systemFont(ofSize: textSize, weight: .bold)
            textLabel?.text = text
            textLabel?.textColor = textColor
            textLabel?.textAlignment = .center
            textLabel?.numberOfLines = 0
            textLabel?.adjustsFontSizeToFitWidth = true
            textLabel?.minimumScaleFactor = 0.8
            
            textLabel?.translatesAutoresizingMaskIntoConstraints = false
            mainViewContainer?.addSubview(textLabel!)
            
            NSLayoutConstraint.activate([
                textLabel!.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 10),
                textLabel!.leadingAnchor.constraint(greaterThanOrEqualTo: mainViewContainer!.leadingAnchor, constant: 20),
                textLabel!.trailingAnchor.constraint(lessThanOrEqualTo: mainViewContainer!.trailingAnchor, constant: 20),
                textLabel!.bottomAnchor.constraint(lessThanOrEqualTo: mainViewContainer!.bottomAnchor, constant: -30),
                textLabel!.centerXAnchor.constraint(equalTo: mainViewContainer!.centerXAnchor)
            ])
        }
        
        // MARK: IMAGE
        if customImage != nil {
            imageIcon = UIImageView()
            imageIcon?.clipsToBounds = true
            imageIcon?.layer.cornerRadius = 2
            imageIcon?.contentMode = .scaleAspectFit
            imageIcon?.image = UIImage(named: "aparcar_icon_white")
            
            imageIcon?.translatesAutoresizingMaskIntoConstraints = false
            animationView.addSubview(imageIcon!)
            
            NSLayoutConstraint.activate([
                imageIcon!.topAnchor.constraint(equalTo: animationView.topAnchor, constant: 20),
                imageIcon!.bottomAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -20),
                imageIcon!.leadingAnchor.constraint(equalTo: animationView.leadingAnchor, constant: 20),
                imageIcon!.trailingAnchor.constraint(equalTo: animationView.trailingAnchor, constant: -20)
            ])
        }
        
    }
    
}

// MARK: CUSTOMIZATION PULSE ANIMATION
extension LoadingCustomTools {
    
    public static func setPulseColor(color: UIColor) {
        
        DispatchQueue.main.async {
            LoadingCustomTools.animationView.backgroundColor = color
            LoadingCustomTools.animatableLayer.fillColor = color.cgColor
        }
    }
    
}

