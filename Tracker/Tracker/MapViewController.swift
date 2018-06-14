//
//  MapViewController.swift
//  Tracker
//
//  Created by Sveta on 6/4/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  
  let currentActivity = CurrentActivity.sharedInstance
  
  @IBOutlet weak var theMap: MKMapView!
  
  @IBAction func CancelButton(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  //  @IBOutlet weak var theLabel: UILabel!
  
  var manager = CLLocationManager()
  var myLocations: [CLLocation] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Setup our Location Manager
    //manager = CLLocationManager()
    manager.delegate = self
    manager.desiredAccuracy = kCLLocationAccuracyBest
    manager.requestWhenInUseAuthorization()
    manager.requestAlwaysAuthorization()
    manager.startUpdatingLocation()
    
    //Setup our Map View
    theMap.delegate = self
    theMap.mapType = MKMapType.standard
    theMap.showsUserLocation = true
    theMap.showsScale = true
  }

  internal func locationManager(_ manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
    //var myLocation = locations[0]
   // theLabel.text = "\(locations[0])"
    myLocations.append(locations[0] )
    
    let spanX = 0.01
    let spanY = 0.01
    let newRegion = MKCoordinateRegion(center: theMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
    theMap.setRegion(newRegion, animated: true)
    
    if (myLocations.count > 1){
      let sourceIndex = myLocations.count - 1
      let destinationIndex = myLocations.count - 2
      
      let c1 = myLocations[sourceIndex].coordinate
      
      currentActivity.startPoint = (c1.latitude, c1.longitude)
      let c2 = myLocations[destinationIndex].coordinate
      currentActivity.endPoint = (c2.latitude, c2.longitude)
      print("c1: ", c1)
      
      var a = [c1, c2]
      let polyline = MKPolyline(coordinates: &a, count: a.count)
      theMap.add(polyline)
    }
  }
  
  func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
    
    if overlay is MKPolyline {
      let polylineRenderer = MKPolylineRenderer(overlay: overlay)
      polylineRenderer.strokeColor = UIColor.gray
      polylineRenderer.lineWidth = 2
      return polylineRenderer
    }
    return nil
  }
}
