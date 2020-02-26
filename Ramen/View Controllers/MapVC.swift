//
//  MapVC.swift
//  Ramen
//
//  Created by Student on 12/14/19.
//  Copyright © 2019 Amina Mahmood. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager?
    var locationManager1 = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBAction func zoomOut(_ sender: UIBarButtonItem) {
        locationManager1.startUpdatingLocation()
        let userLocation = locationManager1.location
        
        let mkCoordinateRegion = MKCoordinateRegion(center: userLocation!.coordinate, latitudinalMeters: 4000000, longitudinalMeters: 4000000)
        self.mapView?.setRegion(mkCoordinateRegion, animated: true)
        stopUpdating()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        locationManager = CLLocationManager()
        if CLLocationManager.locationServicesEnabled() {
            locationManager?
            .requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    func startUpdating(){
        locationManager1.startUpdatingLocation()
    }
    
    func stopUpdating(){
        locationManager1.stopUpdatingLocation()
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let mkCoordinateRegion = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(mkCoordinateRegion, animated: true)
        
        //add an annotation
        let point = MKPointAnnotation()
        point.coordinate = CLLocation(latitude: 43.1566, longitude: -77.6088).coordinate
        point.title = "Let's Go, Ramen!"
        point.subtitle = "Check it out!"
        mapView.addAnnotation(point)
    }
}
