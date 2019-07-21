//
//  GradientTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class GradientTools {
    
    public init() {
        
    }
    
    public enum LinearType: String {
        case topBottom
        case bottomTop
        case leftRight
        case rightLeft
    }
    
    public func setGradientLinear(view: UIView, colorA: UIColor, colorB: UIColor, typeLinear: LinearType) {
        
        let colorTop =  colorA.cgColor
        let colorBottom = colorB.cgColor
        
        let gradientLayer = CAGradientLayer()
        
        switch typeLinear {
        case .topBottom:
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.colors = [colorTop, colorBottom]
            break
        case .bottomTop:
            gradientLayer.locations = [0.0, 1.0]
            gradientLayer.colors = [colorBottom, colorTop]
            break
        case .leftRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [colorTop, colorBottom]
            break
        case .rightLeft:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer.colors = [colorBottom, colorTop]
            break
        }
        
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at:0)
    }
    
}
