//
//  QrTool.swift
//  CustomToolsDGP
//
//  Created by David Galán on 08/08/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//


public class QrTool {
    
    public init() {
    }
    
    public func generateQRCode(from string: String) -> UIImage? {
        
        let data = string.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
}
