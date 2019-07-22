//
//  NumberTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

extension Int {
    
    // check if pair number
    public func isPairNumber() -> Bool {
        if self%2 == 0 {
            return true
        } else {
            return false
        }
    }
    
}

public class NumberTools {

    public init() {
        
    }

    public enum NumberResultType: String {
        case hours
        case minutes
        case seconds
    }
    
    public func getTotalTime(value: Any, valueType: NumberResultType, resultType: NumberResultType) -> Int {
        
        var result = 0
        result = passValueToInt(value: value)
        result = passValueToSeconds(value: result, valueType: valueType)
        
        switch resultType {
        case .hours:
            return (result / 3600)
        case .minutes:
            return ((result % 3600) / 60)
        case .seconds:
            return ((result % 3600) % 60)
        }
    }
    
    public func passValueToInt(value: Any) -> Int {
        
        var result = 0
        
        if let value: String = value as? String {
            if value.isNumeric {
                result = Int(value) ?? 0
            }
        } else if let value: Int = value as? Int {
            result = value
        } else if let value: Double = value as? Double {
            result = Int(value)
        }
        
        return result
    }
    
    public func passValueToSeconds(value: Int, valueType: NumberResultType) -> Int {
        
        var result = 0
        
        switch valueType {
        case .hours:
            result = value * 360
            break
        case .minutes:
            result = value * 60
            break
        case .seconds:
            break
        }
        
        return result
    }
}

extension Numeric {

    // create numeric format according to device region
    public func format(numberStyle: NumberFormatter.Style = NumberFormatter.Style.decimal, locale: Locale = Locale.current) -> String? {
        if let num = self as? NSNumber {
            let formater = NumberFormatter()
            formater.numberStyle = numberStyle
            formater.locale = locale
            return formater.string(from: num)
        }
        return nil
    }
    
    public func formatCustomDecimal(withoutDecimals: Bool = false) -> String? {
        return formatCustom(numberStyle: .decimal, withoutDecimals: withoutDecimals)
    }
    
    public func formatCustomCurrency() -> String? {
        return formatCustom(numberStyle: .currency)
    }
    
    public func formatCustomPercent() -> String? {
        return formatCustom(numberStyle: .percent)
    }
    
    public func formatCustomCurrencyNoSymbol() -> String? {
        
        var value: String = formatCustom(numberStyle: .currency) ?? ""
        
        if value.count > 2 {
            value.removeLast(2)
        }
        
        return value
    }
    
    public func formatCustom(numberStyle: NumberFormatter.Style, withoutDecimals: Bool = false) -> String? {
        if let num = self as? NSNumber {
            let formater = NumberFormatter()
            formater.numberStyle = numberStyle
            formater.locale = Locale(identifier: CurrencyType.es.rawValue)
            
            if !withoutDecimals {
                formater.minimumFractionDigits = 2
                formater.maximumFractionDigits = 2
                formater.multiplier = 1
            }
            return formater.string(from: num)
        }
        return ""
    }

}

public enum CurrencyType: String {
    case es = "es_ES"
}
