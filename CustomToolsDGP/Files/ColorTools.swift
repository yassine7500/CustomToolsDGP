//
//  ColorTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class ColorTools {
    
    public init() {
        
    }
    
    public func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public func compareTwoColors(colorA: UIColor, colorB: UIColor) -> Bool {
        
        var result = false
        
        let colorAString = colorA.setUIColorToHexString()
        let colorBString = colorB.setUIColorToHexString()
        
        if colorAString == colorBString {
            result = true
        }
        
        return result
    }
    
    public func getColorBetweenRange(lightColor: UIColor, darkColor: UIColor, colorDivisions: CGFloat, colorPosition: CGFloat) -> UIColor? {
        
        guard colorPosition < colorDivisions else {
            return nil
        }
        
        // COLOR ONE
        let colorA = lightColor
        _ = colorA.coreImageColor
        let redValueOne: CGFloat = colorA.components.red
        let greenValueOne: CGFloat = colorA.components.green
        let blueValueOne: CGFloat = colorA.components.blue
        let alphaValueOne: CGFloat = colorA.components.alpha
        
        // COLOR TWO
        let colorB = darkColor
        _ = colorB.coreImageColor
        let redValueTwo: CGFloat = colorB.components.red
        let greenValueTwo: CGFloat = colorB.components.green
        let blueValueTwo: CGFloat = colorB.components.blue
        let alphaValueTwo: CGFloat = colorB.components.alpha
            
        let redDifference = abs(redValueOne - redValueTwo)
        let greenDifference = abs(greenValueOne - greenValueTwo)
        let blueDifference = abs(blueValueOne - blueValueTwo)
        let alphaDifference = abs(alphaValueOne - alphaValueTwo)
        
        let redProportion = redDifference/colorDivisions
        let greenProportion = greenDifference/colorDivisions
        let blueProportion = blueDifference/colorDivisions
        let alphaProportion = alphaDifference/colorDivisions
        
        var redResult: CGFloat = 0
        var greenResult: CGFloat = 0
        var blueResult: CGFloat = 0
        var alphaResult: CGFloat = 1.0
        
        if redValueOne < redValueTwo {
            redResult = redValueOne + (redProportion*CGFloat(colorPosition))
        } else {
            redResult = redValueOne - (redProportion*CGFloat(colorPosition))
        }
        
        if greenValueOne < greenValueTwo {
            greenResult = greenValueOne + greenProportion*CGFloat(colorPosition)
        } else {
            greenResult = greenValueOne - greenProportion*CGFloat(colorPosition)
        }
        
        if blueValueOne < blueValueTwo {
            blueResult = blueValueOne + blueProportion*CGFloat(colorPosition)
        } else {
            blueResult = blueValueOne - blueProportion*CGFloat(colorPosition)
        }
        
        if alphaValueOne < alphaValueTwo {
            alphaResult = alphaValueOne + alphaProportion*CGFloat(colorPosition)
        } else {
            alphaResult = alphaValueOne - alphaProportion*CGFloat(colorPosition)
        }
        
        return UIColor(red: redResult, green: greenResult, blue: blueResult, alpha: alphaResult)
    }
    
}

extension UIColor {
    
    // MARK: - Initialization
    convenience init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt32 = 0
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 1.0
        
        let length = hexSanitized.count
        
        guard Scanner(string: hexSanitized).scanHexInt32(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
            
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            g = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
            
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    // MARK: - Computed Properties
    public var toHex: String? {
        return setUIColorToHexString()
    }
    
    // MARK: - From UIColor to String
    public func setUIColorToHexString(alpha: Bool = false) -> String? {
        guard let components = cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        var a = Float(1.0)
        
        if components.count >= 4 {
            a = Float(components[3])
        }
        
        if alpha {
            return String(format: "%02lX%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255), lroundf(a * 255))
        } else {
            return String(format: "%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
    }
    
}

extension UIColor {
    public var coreImageColor: CIColor {
        return CIColor(color: self)
    }
    public var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }
}

