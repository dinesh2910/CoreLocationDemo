//
//  CustomPinAnnotation.swift
//  CoreLocationDemo
//
//  Created by dinesh danda on 10/3/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit
import MapKit

class CustomPinAnnotation: NSObject, MKAnnotation {

    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
    
    class func createViewAnnotationForMapView(mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        
        var returnedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CustomPinAnnotation.self))
        
        if returnedAnnotationView == nil {
            
            returnedAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: NSStringFromClass(CustomPinAnnotation.self))
            
            (returnedAnnotationView as! MKPinAnnotationView).pinTintColor = MKPinAnnotationView.purplePinColor()
            (returnedAnnotationView as! MKPinAnnotationView).animatesDrop = true
            (returnedAnnotationView as! MKPinAnnotationView).canShowCallout = true
            
            
            
        }
        
        return returnedAnnotationView!
        
    }
    
    
    
    
    
    
}
