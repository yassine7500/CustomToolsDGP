//
//  PrintTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 07/09/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public enum PrintType: String {
    case blue = "📘"
    case green = "📗"
    case orange = "📙"
    case red = "📕"
    
    case warning = "⚠️"
    
}

public func print(text: String, type: PrintType = .warning) {
    print("\t\(type.rawValue) : \(text)\n")
}
