//
//  LocationTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import CoreLocation

public protocol LocationDeciveProtocol {
    func passLocationResult(latitude: Double?, longitude: Double?)
}

public class LocationTools: NSObject, CLLocationManagerDelegate {

    public static let sharedInstance = LocationTools()
    
    let locationManager = CLLocationManager()
    var delegateLocationDevice: LocationDeciveProtocol?
    var locationSaved = false
    
    public func startService(delegate: LocationDeciveProtocol, completionError: @escaping (Bool) -> ()) {
        
        PermissionTools().checkLocationPermission { (status) in
            
            if status == 1 {
                self.askLocationPermission()
                completionError(false)
                
            } else if status == 2 {
                self.delegateLocationDevice = delegate
                self.locationSaved = false
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.startUpdatingLocation()
                completionError(false)
                
            } else {
                completionError(true)
                
            }
        }
    }
    
    public func askLocationPermission() {
        // Authorizations
        locationManager.requestAlwaysAuthorization() // Ask for Authorization from the User.
        locationManager.requestWhenInUseAuthorization() // For use in foreground
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else {
            
            self.locationManager.stopUpdatingLocation()
            print(text: "[ERROR] User Location: nil - nil", type: .error)
            self.delegateLocationDevice?.passLocationResult(latitude: nil, longitude: nil)
            return
        }
        
        if !self.locationSaved {
            print(text: "User Location: \(locValue.latitude) - \(locValue.longitude)", type: .address)
            self.locationSaved = true
            self.locationManager.stopUpdatingLocation()
            self.delegateLocationDevice?.passLocationResult(latitude: locValue.latitude, longitude: locValue.longitude)
        }
    }
    
    public func getDistanceBetweenTwoLocations(firstLocation: CLLocation, secondLocation: CLLocation) -> String {
        
        let distance = firstLocation.distance(from: secondLocation)/1000
        let distanceFormatted = distance.formatCustomNumberDecimal() ?? 0.0
        
        if Int(truncating: distanceFormatted) < 1 {
            return "\(Int(Int(truncating: distanceFormatted)*1000)) m"
        } else {
            return "\(distanceFormatted) Km"
        }
    }

}
