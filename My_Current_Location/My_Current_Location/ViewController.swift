//
//  ViewController.swift
//  My_Current_Location
//
//  Created by MSC_INDIA on 07/06/24.
//

//Push it to the github

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if(CLLocationManager.locationServicesEnabled())
        {
            locationManager.requestLocation()
            locationManager.startUpdatingLocation()
        }
    }


    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first
        {
            manager.stopUpdatingLocation()
            
            let coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            let region = MKCoordinateRegion(center: coordinates, span: span)
            
            myMap.setRegion(region, animated: true)
            
            let myPin = MKPointAnnotation()
            myPin.coordinate = coordinates
            
            myPin.title = "CABCS GROUP INDIA"
            myPin.subtitle = "Bengaluru"
            
            myMap.addAnnotation(myPin)
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
     switch manager.authorizationStatus {
         case .authorizedAlways:
              return
            
         case .authorizedWhenInUse:
              return
            
         case .denied:
              return
            
         case .restricted:
          locationManager.requestWhenInUseAuthorization()
            
         case .notDetermined:
          locationManager.requestWhenInUseAuthorization()
         
         default:
          locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    
    
}

