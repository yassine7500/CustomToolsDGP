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
    
    /// ➡️
    case arrowRight = "➡️"
    /// ⬅️
    case arrowLeft = "⬅️"
    /// ⬆️
    case arrowUp = "⬆️"
    /// ⬇️
    case arrowDown = "⬇️"
    
    
    /// 🔄
    case update = "🔄"
    /// 💾
    case save = "💾"
    /// 💛
    case favYellow = "💛"
    /// 🆔
    case id = "🆔"
    /// 🆘
    case sos = "🆘"
    /// ⛔️
    case forbidden = "⛔️"
    /// ℹ️
    case information = "ℹ️"
    /// ⤴️
    case upload = "⤴️"
    /// ⤵️
    case download = "⤵️"
    /// 🚀
    case rocket = "🚀"
    
    /// 🗄
    case database = "🗄"
    /// 📄
    case file = "📄"
    /// 📊
    case grafic = "📊"
    /// 📝
    case note = "📝"
    /// 🔍
    case search = "🔍"
    /// 🛠
    case tools = "🛠"
    /// ⚙️
    case configuration = "⚙️"
    
    
    
}

public func print(text: String, type: PrintType = .warning) {
    print("\n\t\(type.rawValue) : \(text)\n")
}
