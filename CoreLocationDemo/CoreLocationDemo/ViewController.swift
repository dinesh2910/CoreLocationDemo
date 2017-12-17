//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by dinesh danda on 10/3/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // Movement threshold for sending new update location events
        //locationManager.distanceFilter = 500 // meters
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            let locationUpdateTime = location.timestamp
            let locationTimeInterval = locationUpdateTime.timeIntervalSinceNow
            
            if (abs(locationTimeInterval)) < 15.0 {
                
                let lat = location.coordinate.latitude
                let long = location.coordinate.longitude
                //print("Latitude: \(lat), Longitude: \(long)")
                
                CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemark: [CLPlacemark]?, error: Error?) in
                    
                    if (placemark?.count)! > 0 {
                        
                        let firstPlacemark = placemark?.first
                        
                        let subthoroughfare = firstPlacemark?.subThoroughfare != nil ? firstPlacemark?.subThoroughfare : "Sub Thouroghfare date no found"
                        
                        let thoroughfare = firstPlacemark?.thoroughfare != nil ? firstPlacemark?.thoroughfare : "Thouroughfare data not found"
                        
                        let country = firstPlacemark?.country != nil ? firstPlacemark?.country : "Country data not found"
                    
                        let locationString = "\(subthoroughfare!) : \(thoroughfare!) : \(country!)"
                        
                        print(locationString)
                        
                    }
                    
                    
                })
                
            }
        }
        
        
        
        
        
    }
    

    


}

