//
//  DeviceTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 20/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

public class DeviceTools {
    
    public init() {
        
    }
    
    public func openAppSystemConfiguration() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }
    
}
