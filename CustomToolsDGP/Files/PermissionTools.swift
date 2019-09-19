//
//  PermissionTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 19/09/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UserNotifications

public class PermissionTools {
    
    public init() {
        
    }
    
    public func checkNotificationPermission(completion: @escaping (Bool) -> ()) {
        
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            
            if settings.authorizationStatus == .authorized {
                print(text: "Notification permission: TRUE", type: .success)
                completion(true)
            } else {
                print(text: "Notification permission: FALSE", type: .warning)
                completion(false)
            }
        }
    }
    
}
