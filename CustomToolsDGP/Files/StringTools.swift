//
//  StringTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

extension String {
    
    var isNumeric: Bool {
        
        if Int(self) != nil || Double(self) != nil || Float(self) != nil {
            return true
        } else {
            return false
        }
        
        //        guard self.characters.count > 0 else { return false }
        //        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        //        return Set(self.characters).isSubset(of: nums)
    }
    
    var toLocale: Locale {
        return Locale(identifier: self)
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
    
}
