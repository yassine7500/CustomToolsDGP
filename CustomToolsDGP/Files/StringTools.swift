//
//  StringTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public enum CapitalizeString: Int {
    case none = 0
    case uppercased = 1
    case lowercased = 2
    case capitalized = 3
}

extension String {
    
    public var isNumeric: Bool {
        
        if Int(self) != nil || Double(self) != nil || Float(self) != nil {
            return true
        } else {
            return false
        }
        
        //        guard self.characters.count > 0 else { return false }
        //        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        //        return Set(self.characters).isSubset(of: nums)
    }
    
    public var toLocale: Locale {
        return Locale(identifier: self)
    }
    
    public func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    public func underlineText() ->  NSMutableAttributedString {
        let textRange = NSMakeRange(0, self.count)
        let attributedText = NSMutableAttributedString(string: self)
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.single.rawValue, range: textRange)
        return attributedText
    }
    
    public func isValidPassword() -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[A-Za-z\\d$@$!%*?&]{6,}"
        let passowrdTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passowrdTest.evaluate(with: self)
    }
    
    public func getStringValue(value: Any) -> String {
        
        var result = ""
        
        if let value: String = value as? String {
            result = value
        } else if let value: Int = value as? Int {
            result = "\(value)"
        } else if let value: Double = value as? Double {
            result = "\(value)"
        }
        
        return result
    }
    
}

public class StringTools {
    
    public init() {
        
    }
    
    public func replaceCharacterCustom(text: String, inCharacter: String, outCharacter: String, options: NSString.CompareOptions = .literal) -> String {
        return text.replacingOccurrences(of: inCharacter, with: outCharacter, options: options, range: nil)
    }
    
    public func countWords(text: String) -> Int {
        let components = text.components(separatedBy: .whitespacesAndNewlines)
        let words = components.filter { !$0.isEmpty }
        return words.count
    }
    
    public func setCustomText(text: String, size: CGFloat = 14, weight: UIFont.Weight = .medium, color: UIColor? = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), jumpSpace: Bool = false) -> NSAttributedString {
        
        let labelFont = UIFont.systemFont(ofSize: size, weight: weight)
        var attributes: [NSAttributedString.Key : Any]!
        
        if color != nil {
            attributes = [NSAttributedString.Key.font : labelFont, NSAttributedString.Key.foregroundColor : color!]
        } else {
            attributes = [NSAttributedString.Key.font : labelFont]
        }
        
        let textAattr = NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        
        let result = NSMutableAttributedString()
        result.append(textAattr)
        
        if jumpSpace {
            let textSpace = NSAttributedString(string: "\n")
            result.append(textSpace)
        }
        
        return result
    }
    
    public func setCustomTwoTexts(textA: String, textB: String, sizeA: CGFloat = 20, sizeB: CGFloat = 20, weightA: UIFont.Weight = .medium, weightB: UIFont.Weight = .medium, colorA: UIColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), colorB: UIColor = #colorLiteral(red: 0.4, green: 0.4, blue: 0.4, alpha: 1), jumpSpace: Bool = false) -> NSAttributedString {
        
        var labelFont = UIFont.systemFont(ofSize: sizeA, weight: weightA)
        var attributes: Dictionary = [NSAttributedString.Key.font : labelFont, NSAttributedString.Key.foregroundColor : colorA]
        let textAattr = NSAttributedString(string: textA, attributes: attributes as [NSAttributedString.Key : Any])
        
        labelFont = UIFont.systemFont(ofSize: sizeB, weight: weightB)
        attributes = [NSAttributedString.Key.font : labelFont, NSAttributedString.Key.foregroundColor : colorB]
        let textBattr = NSAttributedString(string: textB, attributes: attributes as [NSAttributedString.Key : Any])
        
        let result = NSMutableAttributedString()
        result.append(textAattr)
        
        if jumpSpace {
            let textSpace = NSAttributedString(string: "\n")
            result.append(textSpace)
        }
        result.append(textBattr)
        
        return result
    }
    
    
    public func setCustomTextBoldBetweenTexts(textA: String, textBold: String, textB: String, withJumpSpace: Bool) -> NSMutableAttributedString {
        
        let messageText = NSMutableAttributedString()
        let textA = setCustomText(text: textA, size: 20, weight: .regular, color: nil, jumpSpace: withJumpSpace)
        let textBold = setCustomText(text: textBold, size: 20, weight: .bold, color: nil, jumpSpace: withJumpSpace)
        let textB = setCustomText(text: textB, size: 20, weight: .regular, color: nil, jumpSpace: withJumpSpace)
        
        messageText.append(textA)
        messageText.append(textBold)
        messageText.append(textB)
        
        return messageText
    }
    
}
