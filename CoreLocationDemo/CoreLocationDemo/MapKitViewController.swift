//
//  MapKitViewController.swift
//  CoreLocationDemo
//
//  Created by dinesh danda on 10/3/16.
//  Copyright © 2016 dinesh danda. All rights reserved.
//

import UIKit
import MapKit

class MapKitViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, PassTitles {

    @IBOutlet var myMapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var overlay = MKCircle()
    
    var latDelta: CLLocationDegrees = 0.2
    var longDelta: CLLocationDegrees = 0.2
    
    var location2D = CLLocationCoordinate2D()
    
    var touchMapCoordinate = CLLocationCoordinate2D()
    var annotationTitle: String?
    var annotationSubTitle: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //myMapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(gesture:))))
        myMapView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(callTitlesView(gesture:))))
        
        myMapView.delegate = self
        
    }
    
    func callTitlesView(gesture: UIGestureRecognizer) {
        
        if gesture.state != .began {
            return
        }
        
        let touchPoint = gesture.location(in: self.myMapView)
        touchMapCoordinate = myMapView.convert(touchPoint, toCoordinateFrom: self.myMapView)
        
        self.performSegue(withIdentifier: "titlesSegue", sender: self)
        
    }
    
    func setTitles(title: String, subTitle: String) {
        self.annotationTitle = title
        self.annotationSubTitle = subTitle
        
        print(annotationTitle!)
        print(annotationSubTitle!)
        
        addAnnotation()
        
    }
    
    //func addAnnotation(gesture: UIGestureRecognizer) {
    func addAnnotation() {
        
        /*
        if gesture.state != .began {
            return
        }
        
        let touchPoint = gesture.location(in: self.myMapView)
        let touchMapCoordinate = myMapView.convert(touchPoint, toCoordinateFrom: self.myMapView)
        */
        
        //let annotation = MKPointAnnotation()
        //annotation.coordinate = touchMapCoordinate
        //myMapView.addAnnotation(annotation)
        
        //let customImageAnnotation = CustomImageAnnotation(coordinate: touchMapCoordinate, title: "Flag Annotation Title", subtitle: "Flag Annotation Subtitle")
        
        //let customImageAnnotation = CustomImageAnnotation(coordinate: touchMapCoordinate, title: annotationTitle!, subtitle: annotationSubTitle!)
        
        let customPinAnnotation = CustomPinAnnotation(coordinate: touchMapCoordinate, title: annotationTitle!, subtitle: annotationSubTitle!)
        
        myMapView.addAnnotation(customPinAnnotation)
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnnotation")
        //annotationView.animatesDrop = true
        //annotationView.pinTintColor = UIColor.blue
        
        var returnedAnnotationView: MKAnnotationView? = nil
        
        if annotation.isKind(of: CustomImageAnnotation.self) {
            
            returnedAnnotationView = CustomImageAnnotation.createViewAnnotationForMapView(mapView: myMapView, annotation: annotation)
            
        } else if annotation.isKind(of: CustomPinAnnotation.self) {
            
            returnedAnnotationView = CustomPinAnnotation.createViewAnnotationForMapView(mapView: self.myMapView, annotation: annotation)
            
            let rightButton = UIButton(type: .detailDisclosure)
            rightButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            returnedAnnotationView?.rightCalloutAccessoryView = rightButton
            
            let imageView = UIImageView(image: UIImage(named: "flag"))
            returnedAnnotationView?.detailCalloutAccessoryView = imageView
            
            
            
        }
        
        
        return returnedAnnotationView
        
    }
    
    func buttonPressed() {
        print("Pin Call Out Button was pressed")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            let latitude: CLLocationDegrees = location.coordinate.latitude
            let longitude: CLLocationDegrees = location.coordinate.longitude
            
            let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
            location2D = CLLocationCoordinate2DMake(latitude, longitude)
            
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location2D, span)
            myMapView.setRegion(region, animated: true)
            
            if !myMapView.overlays.isEmpty {
                myMapView.remove(overlay)
            }
            
            // Display overlay on the map
            overlay = MKCircle(center: location2D, radius: 60)
            myMapView.add(overlay)
            
            
        }
        
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor(colorLiteralRed: 0, green: 0, blue: 1.0, alpha: 0.6)
        circleRenderer.fillColor = UIColor(colorLiteralRed: 1.0, green: 0, blue: 0, alpha: 0.6)
        
        return circleRenderer
    }
    
    func mapView(_ mapView: MKMapView, didAdd renderers: [MKOverlayRenderer]) {
        self.locationManager.stopUpdatingLocation()
    }
    

    @IBAction func zoomOut(_ sender: UIBarButtonItem) {
        
        latDelta = myMapView.region.span.latitudeDelta * 2
        longDelta = myMapView.region.span.longitudeDelta * 2
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: myMapView.region.center, span: span)
        
        myMapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func zoomIn(_ sender: UIBarButtonItem) {
        
        latDelta = myMapView.region.span.latitudeDelta / 2
        longDelta = myMapView.region.span.longitudeDelta / 2
        
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: longDelta)
        let region = MKCoordinateRegion(center: myMapView.region.center, span: span)
        
        myMapView.setRegion(region, animated: true)
        
    }
    
    @IBAction func currentLocation(_ sender: UIBarButtonItem) {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "titlesSegue" {
            let destination = segue.destination as! TitlesViewController
            destination.delegate = self
        }
        
        
    }
    

}
