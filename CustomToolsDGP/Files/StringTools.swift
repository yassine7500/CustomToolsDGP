//
//  StringTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

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
