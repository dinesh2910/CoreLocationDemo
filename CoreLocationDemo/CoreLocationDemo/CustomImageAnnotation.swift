//
//  CustomImageAnnotation.swift
//  CoreLocationDemo
//
//  Created by dinesh danda on 10/3/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit
import MapKit

class CustomImageAnnotation: NSObject, MKAnnotation {

    // Coordinate
    // Title
    // Optional - Subtitle
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
    }
    
    class func createViewAnnotationForMapView(mapView: MKMapView, annotation: MKAnnotation) -> MKAnnotationView {
        
        var returnedAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: NSStringFromClass(CustomImageAnnotation.self))
        
        if returnedAnnotationView == nil {
            
            // Setup for returnedAnnotationView
            
            returnedAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: NSStringFromClass(CustomImageAnnotation.self))
            
            returnedAnnotationView?.canShowCallout = true
            
            returnedAnnotationView?.image = UIImage(named: "flag")
            
            let buildingView = UIImageView(image: UIImage(named: "building"))
            returnedAnnotationView?.leftCalloutAccessoryView = buildingView
            
            let offsetX: CGFloat = (returnedAnnotationView?.centerOffset.x)! + (returnedAnnotationView?.image?.size.width)! / 2 - 12
            let offsetY: CGFloat = (returnedAnnotationView?.centerOffset.y)! - (returnedAnnotationView?.image?.size.height)! / 2
            
            returnedAnnotationView?.centerOffset = CGPoint(x: offsetX, y: offsetY)
            
            
        } else {
            
            returnedAnnotationView?.annotation = annotation
        }
        
        return returnedAnnotationView!
        
    }
    
    
    
    
}
