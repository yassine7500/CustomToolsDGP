//
//  Md5hashTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 23/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


public class Md5hashTool {
    
    public init() {
        
    }
    
    public func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }
    
    public func encryptData (data: String) -> String {
        let md5Data = MD5(string: data)
        let md5Hex = md5Data.map { String(format: "%02hhx", $0) }.joined()
        return md5Hex
    }
    
}
