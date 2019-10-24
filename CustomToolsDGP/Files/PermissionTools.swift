//
//  PermissionTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 19/09/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import UserNotifications
import AVFoundation
import CoreLocation

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
    
    public func checkCameraPermission(completion: @escaping (Bool) -> ()) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
            if response {
                //access granted
                print(text: "CAMERA access granted", type: .success)
                completion(true)
            } else {
                print(text: "CAMERA access rejected", type: .warning)
                completion(false)
            }
        }
    }
    
    public func checkLocationPermission(completion: @escaping (Int) -> ()) {
        
        if CLLocationManager.locationServicesEnabled() {
            
            switch CLLocationManager.authorizationStatus() {
                
            case .restricted, .denied:
                print(text: "Location permission denied", type: .warning)
                completion(0)
            case .notDetermined:
                print(text: "Location permission notDetermined", type: .exclamationRed)
                completion(1)
            case .authorizedAlways, .authorizedWhenInUse:
                print(text: "Location permission authorized", type: .success)
                completion(2)
            @unknown default:
                print(text: "Location permission denied (@unknown default)", type: .warning)
                completion(0)
            }
        } else {
            print(text: "Location permission disables", type: .warning)
            completion(0)
        }
    }
    
}
