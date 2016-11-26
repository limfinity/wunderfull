//
//  LocationMapViewController.swift
//  Wunderfull
//
//  Created by Peter Pult on 26/11/2016.
//  Copyright © 2016 Peter Pult. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class LocationMapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }
    
    /// Whether the map is centered
    fileprivate var centered = true
    
    /// Location manager for handling location and location authorization
    fileprivate var locationManager: CLLocationManager! {
        didSet {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    /// A realm notification
    fileprivate var notification: NotificationToken? = nil
    
    /// All car locations
    fileprivate var locations = realm.getAllLocations()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        dropPins(onMapView: mapView, forLocations: locations)
        
        notification = realm.objects(Location.self).addNotificationBlock { [weak self] (changes: RealmCollectionChange<Results<Location>>) in
            guard let sSelf = self else { return }
            sSelf.dropPins(onMapView: sSelf.mapView, forLocations: sSelf.locations)
        }
    }
    
    deinit {
        notification?.stop()
    }
    
    func dropPins(onMapView mapView: MKMapView, forLocations locations: [Location]) {
        // Remove all previous annotations except for the user location annotation
        mapView.removeAnnotations(mapView.annotations.filter { !($0 is MKUserLocation) })
        
        locations.forEach { location in
            let pin = MKPointAnnotation()
            pin.coordinate = (location.coordinates?.clLocation.coordinate)!
            pin.title = location.name
            mapView.addAnnotation(pin)
        }
    }
    
    func center(map mapView: MKMapView, toLocation location: CLLocation? = nil, animated: Bool = true) {
        guard let location = location ?? mapView.userLocation.location else { return print("Error centering map view.") }
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: animated)
    }
    
}

extension LocationMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if centered {
            let location = locations.last
            center(map: mapView, toLocation: location, animated: true)
        }
    }
}

extension LocationMapViewController: MKMapViewDelegate {
    
    /// Determines if given map view was changed because of a user interaction.
    private func userInteractionForcedUpdateOn(mapView: MKMapView) -> Bool {
        guard let view = mapView.subviews.first else {
            return false
        }
        guard let gestureRecognizers = view.gestureRecognizers else {
            return false
        }
        for recognizer in gestureRecognizers {
            if recognizer.state == UIGestureRecognizerState.began || recognizer.state == UIGestureRecognizerState.ended {
                return true
            }
        }
        return false
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        centered = !userInteractionForcedUpdateOn(mapView: mapView)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if centered {
            mapView.setCenter(userLocation.coordinate, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        mapView.annotations.forEach { annotation in
            mapView.view(for: annotation)?.isHidden = true
        }
        view.isHidden = false
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        if view.annotation is MKUserLocation {
            return
        }
        mapView.annotations.forEach { annotation in
            mapView.view(for: annotation)?.isHidden = false
        }
    }
    
}



