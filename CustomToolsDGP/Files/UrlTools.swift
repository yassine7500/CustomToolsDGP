//
//  UrlTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


extension String {
    
    public func isValidURL() -> Bool {
        guard let _ = URL(string: self) else { return false }
        //        if !UIApplication.shared.canOpenURL(url) {
        //            return false
        //        }
        
        let urlPattern = "^(http|https|ftp)\\://([a-zA-Z0-9\\.\\-]+(\\:[a-zA-Z0-9\\.&amp;%\\$\\-]+)*@)*((25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9])\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[1-9]|0)\\.(25[0-5]|2[0-4][0-9]|[0-1]{1}[0-9]{2}|[1-9]{1}[0-9]{1}|[0-9])|localhost|([a-zA-Z0-9\\-]+\\.)*[a-zA-Z0-9\\-]+\\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(\\:[0-9]+)*(/($|[a-zA-Z0-9\\.\\,\\?\\'\\\\\\+&amp;%\\$#\\=~_\\-]+))*$"
        return self.matches(pattern: urlPattern)
    }
    
    private func matches(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(
            pattern: pattern,
            options: [.caseInsensitive])
        return regex.firstMatch(
            in: self,
            options: [],
            range: NSRange(location: 0, length: utf16.count)) != nil
    }
    
    // open url
    public func openUrl() {
        if self.isValidURL() {
            let urlOpen = URL(string: self)!
            if UIApplication.shared.canOpenURL(urlOpen) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(urlOpen)
                } else {
                    UIApplication.shared.openURL(urlOpen)
                }
            }
        }
    }
    
}

public class UrlTools {
    
    public init() {
        
    }
    
    public func setUrlStartWithHttp(urlString: String) -> String {
        
        var url = urlString
        
        if !(url.hasPrefix("https://")) {
            if !(url.hasPrefix("http://")) {
                url = "http://" + (url)
            }
        }
        
        return url
    }
    
    public func setUrlStartWithHttps(urlString: String) -> String {
        
        var url = urlString
        
        if !(url.hasPrefix("https://")) {
            if !(url.hasPrefix("http://")) {
                url = "https://" + (url)
            }
        }
        
        return url
    }
    
}
