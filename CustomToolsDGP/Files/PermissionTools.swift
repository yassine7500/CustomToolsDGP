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
import Photos

public class PermissionTools {
    
    public init() {
        
    }
    
    // MARK: NOTIFICATIONS PERMISSION STATUS
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
    
    // MARK: LOCATION PERMISSION STATUS
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
    
    // MARK: MICROPHONE PERMISSION STATUS
    public enum MicrophonePermissionStatus {
        case granted
        case denied
        case undetermined
    }
    
    public func checkMicrophonePermission(completionStatus: @escaping (MicrophonePermissionStatus) -> ()) {
        
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            completionStatus(.granted)
        case AVAudioSessionRecordPermission.denied:
            completionStatus(.denied)
        case AVAudioSessionRecordPermission.undetermined:
            
            self.askMicrophonePermission { (granted) in
                
                if granted {
                    completionStatus(.granted)
                } else {
                    completionStatus(.denied)
                }
            }
            
        default:
            completionStatus(.denied)
            break
        }
        
    }
    
    public func askMicrophonePermission(grantedValue: @escaping (Bool) -> ()) {
        
        AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
            if granted {
                print(text: "Microphone permission: TRUE", type: .success)
                grantedValue(true)
            } else {
                print(text: "Microphone permission: FALSE", type: .warning)
                grantedValue(false)
            }
        })
    }
    
    // MARK: CAMERA PERMISSION STATUS
    public enum VideoPermissionStatus {
        case granted
        case denied
        case restricted
        case notDetermined
    }
    
    public func checkCameraPermission(completionStatus: @escaping (VideoPermissionStatus) -> ()) {
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .notDetermined:
            
            self.askCameraPermission { (granted) in
                if granted {
                    completionStatus(.granted)
                } else {
                    completionStatus(.denied)
                }
            }
            
        case .restricted:
            completionStatus(.restricted)
        case .denied:
            completionStatus(.denied)
        case .authorized:
            completionStatus(.granted)
        @unknown default:
            completionStatus(.denied)
        }
        
    }
    
    public func askCameraPermission(grantedValue: @escaping (Bool) -> ()) {
        
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
            if granted {
                print(text: "Microphone permission: TRUE", type: .success)
                grantedValue(true)
            } else {
                print(text: "Microphone permission: FALSE", type: .warning)
                grantedValue(false)
            }
        })
        
    }
    
    public func photoLibraryPermission(grantedValue: @escaping (Bool) -> ()) {
        
        PHPhotoLibrary.requestAuthorization { (status) in

            if status.rawValue == 3 {
                print(text: "Photo library permission: TRUE", type: .success)
                grantedValue(true)
            } else {
                print(text: "Photo library permission: FALSE", type: .warning)
                grantedValue(false)
            }
        }
        
    }

}
