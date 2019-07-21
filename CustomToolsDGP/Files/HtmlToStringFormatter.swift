//
//  HtmlToStringFormatter.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class HtmlToStringFormatter {
    
    public init() {
        
    }
    
    // convert HTML to String
    public func html2String(htmlText: String, textAttrs: Bool = false, systemFontSize: CGFloat = 14, fontColor: UIColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)) -> NSAttributedString? {
        guard let htmlData = htmlText.data(using: .utf8) else
        {
            print("Could not get htmlData")
            return nil
        }
        do {
            
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue,
            ]
            
            let textFormatted = try NSAttributedString(data: htmlData, options: options, documentAttributes: nil)

            if textAttrs {
                
                let attrs: [NSAttributedString.Key : Any]  = [
                    NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue) : UIFont.systemFont(ofSize: systemFontSize)
                    ,NSAttributedString.Key.foregroundColor : fontColor]
                
                return NSAttributedString(string: textFormatted.string, attributes: attrs)
            } else {
                return textFormatted
            }
  
        } catch let error {
            print(error)
            return nil
        }
    }
    
}
