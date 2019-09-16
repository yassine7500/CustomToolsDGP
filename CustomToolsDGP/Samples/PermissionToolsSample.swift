//
//  PermissionToolsSample.swift
//  CustomToolsDGP
//
//  Created by David Galán on 22/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//
//
//import Foundation
//import UserNotifications
//import AVFoundation
//import CoreLocation
//
//
//extension UIViewController {
//
//    func checkNotificationPermission() {
//        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
//
//            guard settings.authorizationStatus == .authorized else {
//                print("Notification permission: FALSE")
//                DispatchQueue.main.async {
//                    self.alertNotificationPermission()
//                }
//                return
//            }
//            print("Notification permission: TRUE")
//        }
//    }
//
//    func alertNotificationPermission() {
//        Aparcar.sharedInstance.setStatusAlertNotifications(value: true)
//        let vc = self.showAlertCustom(title: LangStr.langStr("information_text"), description: LangStr.langStr("permission_alert_text"), buttonText: LangStr.langStr("nav_options[8]").capitalizingFirstLetter())
//        vc.activeCancelButton()
//        vc.addOkAction {
//            openAppSystemConfiguration()
//        }
//    }
//
//
//    func checkLocationPermission(completion: @escaping (Bool) -> ()) {
//
//        if CLLocationManager.locationServicesEnabled() {
//            switch CLLocationManager.authorizationStatus() {
//            case .notDetermined, .restricted, .denied:
//                print("Location - No access")
//                completion(false)
//            case .authorizedAlways, .authorizedWhenInUse:
//                print("Location - Access")
//            @unknown default:
//                print("Location - unknown")
//                completion(false)
//            }
//        } else {
//            print("Location services are not enabled")
//            completion(false)
//        }
//    }
//
//
//    func checkCameraPermission() {
//        AVCaptureDevice.requestAccess(for: AVMediaType.video) { response in
//            if response {
//                //access granted
//                Aparcar.sharedInstance.setCameraPermission(value: true)
//            } else {
//                Aparcar.sharedInstance.setCameraPermission(value: false)
//                self.alertCameraPermission()
//            }
//        }
//    }
//
//    func alertCameraPermission() {
//        DispatchQueue.main.async {
//            let vc = self.showAlertCustom(
//                title: LangStr.langStr("aviso"),
//                description: LangStr.langStr("camera_permission_text"),
//                buttonText: LangStr.langStr("ajustes").capitalizingFirstLetter()
//            )
//
//            vc.activeCancelButton()
//            vc.addOkAction {
//                openAppSystemConfiguration()
//            }
//
//            vc.addCancelAction {
//                self.goToPreviousView()
//            }
//        }
//    }
//
//}
