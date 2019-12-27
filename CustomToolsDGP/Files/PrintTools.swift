//
//  PrintTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 07/09/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public enum PrintType: String {
    
    /// 📘
    case blue = "📘"
    /// 📗
    case green = "📗"
    /// 📙
    case orange = "📙"
    /// 📕
    case red = "📕"
    
    /// ⚠️
    case warning = "⚠️"
    /// ✅
    case success = "✅"
    /// ❌
    case error = "❌"
    
    /// ❗️
    case exclamationRed = "❗️"
    /// ❕
    case exclamationWhite = "❕"
    /// ❓
    case questionRed = "❓"
    /// ❔
    case quesationWhite = "❔"
    /// ‼️
    case exclamationDouble = "‼️"
    /// ⁉️
    case exclamationQuestion = "⁉️"
    
    /// 👍
    case ok = "👍"
    /// 👎
    case nok = "👎"
    
    /// ⏱
    case time = "⏱"
    /// 📅
    case calendar = "📅"
    /// 📌
    case pin = "📌"
    
    /// 🔒
    case lockClose = "🔒"
    /// 🔓
    case lockOpen = "🔓"
    
    /// 🅿️
    case parking = "🅿️"
    /// 🚗
    case car = "🚗"
    /// 🏠
    case address = "🏠"
    /// ☎️
    case phone = "☎️"
    /// ✉️
    case email = "✉️"
    /// 💰
    case money = "💰"
    /// 📎
    case clip = "📎"
    /// 🔑
    case token = "🔑"
    /// 🔋
    case battery = "🔋"
    
    
}

public func print(text: String, type: PrintType = .warning) {
    print("\t\(type.rawValue) : \(text)\n")
}
