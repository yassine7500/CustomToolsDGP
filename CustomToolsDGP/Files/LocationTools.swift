//
//  LocationTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import CoreLocation

public protocol LocationDeciveProtocol {
    func passLocationResult(latitude: Double, longitude: Double)
}

public class LocationTools: NSObject, CLLocationManagerDelegate {

    public static let sharedInstance = LocationTools()
    
    let locationManager = CLLocationManager()
    var delegateLocationDevice: LocationDeciveProtocol?
    
    public func startService(delegate: LocationDeciveProtocol) {
        
        if CLLocationManager.locationServicesEnabled() {
            self.delegateLocationDevice = delegate
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let locValue: CLLocationCoordinate2D = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationManager.stopUpdatingLocation()
        self.delegateLocationDevice?.passLocationResult(latitude: locValue.latitude, longitude: locValue.longitude)
    }

}
