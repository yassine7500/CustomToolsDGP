//
//  MapTools.swift
//  CustomToolsDGP
//
//  Created by David Galán on 21/07/2019.
//  Copyright © 2019 David Galán. All rights reserved.
//

import MapKit

public class MapTools {
    
    var mapView: MKMapView?
    
    public init(map: MKMapView?) {
        self.mapView = map
    }
    
    public enum DirectionMode: String {
        case noRoute
        case driving
        case walking
    }
    
    public func setAnnotationInMap(latitude: Double, longitude: Double, locationDregrees: Double = 0.001, customAnnotation: Bool, title: String = "", subtitle: String = "", imageName: String = "", setRegionAnimated: Bool = true, withEyeCoordinate: Bool = false, eyeCoordinateValue: Double = 0.001, eyeAltitudeValue: Double = 200, setCameraAnimated: Bool = true, setCenterValue: Bool = false, setCenterAnimated: Bool = true) {
        
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: locationDregrees, longitudeDelta: locationDregrees)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegion(center: location, span: span)
        
        if setCenterValue {
            self.mapView?.setCenter(location, animated: setCenterAnimated)
        } else {
            self.mapView?.setRegion(region, animated: setRegionAnimated)
        }
        
        if customAnnotation {
            
            let destinyAnnotation = CustomPointAnnotation()
            destinyAnnotation.coordinate = location
            
            if title != "" {
                destinyAnnotation.title = title
            }
            
            if subtitle != "" {
                destinyAnnotation.subtitle = subtitle
            }
            
            if imageName != "" {
                destinyAnnotation.image = imageName
            }
            
            if withEyeCoordinate {
                let eyeCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude + eyeCoordinateValue, longitude + eyeCoordinateValue)
                let mapCamera = MKMapCamera(lookingAtCenter: location, fromEyeCoordinate: eyeCoordinate, eyeAltitude: eyeAltitudeValue)
                self.mapView?.setCamera(mapCamera, animated: setCameraAnimated)
            }
            
            self.mapView?.addAnnotation(destinyAnnotation)
            
        } else {
            
            let destinyAnnotation = MKPointAnnotation()
            destinyAnnotation.coordinate = location
            if title != "" {
                destinyAnnotation.title = title
            }
            self.mapView?.addAnnotation(destinyAnnotation)
            
        }
    }
    
    public func setMapViewCustomAnnotation(mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if !(annotation is CustomPointAnnotation){
            return nil
        }
        
        let reuseId = "MyCustomAnnotation"
        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.canShowCallout = true
            
        } else {
            anView!.annotation = annotation
        }
        
        let cpa = annotation as! CustomPointAnnotation
        anView!.image = UIImage(named: cpa.image)
        
        return anView
    }
    
}

public class CustomPointAnnotation: MKPointAnnotation {
    public var image: String!
}

extension MapTools {
    
    // open coordinates in map app of device
    public func openMapForPlace(latitude: Double, longitude: Double, placeName: String, directionMode: DirectionMode = .noRoute) {
        
        let latitude: CLLocationDegrees = latitude
        let longitude: CLLocationDegrees = longitude
        
        let regionDistance: CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        var options: [String : Any]!
        
        switch directionMode {
        case .noRoute:
            options = [ MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                        MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span) ]
        case .driving:
            options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        case .walking:
            options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        }
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = placeName
        mapItem.openInMaps(launchOptions: options)
    }
}
