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
  let coredata = CoreDataManager.sharedInstance
  var cor1:CLLocationDegrees!
  var cor2:CLLocationDegrees!
  var cor3:CLLocationDegrees!
  var cor4:CLLocationDegrees!
//  var c2:Double
  var distanceInMeters:Double?
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
      //let
      let c1 = myLocations[sourceIndex].coordinate
      
      let coordinate0 = CLLocation(latitude:c1.latitude , longitude: c1.longitude)
      
     // currentActivity.startPoint = (c1.latitude, c1.longitude)
      cor1 = c1.latitude
      cor2 = c1.longitude
      
      currentActivity.startPoint = (cor1,cor2)
       let c2 = myLocations[destinationIndex].coordinate
      let coordinate1 = CLLocation(latitude:c2.latitude , longitude: c2.longitude)
      //currentActivity.endPoint = (c2.latitude, c2.longitude)
      cor3 = c2.latitude
      cor4 = c2.longitude
      currentActivity.endPoint = (cor3, cor4)
     
      print("c1: ", c1)
      print("cor1: ",cor1)
      print("cor2: ",cor2)
//      let coordinate0 = CLLocation(latitude:c1.latitude , longitude: c1.longitude)
//      let coordinate1 = CLLocation(latitude:c2.latitude , longitude: c2.longitude)
      
       distanceInMeters = coordinate0.distance(from: coordinate1)
     // print(String(format: "The distance to my buddy is %lf m", distanceInMeters))
      
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
  
  @IBAction func saveD(_ sender: Any) {
   
    currentActivity.startPoint = (cor1,cor2)
     currentActivity.endPoint = (cor3,cor4)
   
    currentActivity.date = Date()
    currentActivity.distance = distanceInMeters
    currentActivity.duration = 34//distanceInMeters
    currentActivity.type = 2
    coredata.saveActivity(data: currentActivity) { 
      print("saved:")
    
    }
  }
  
  @IBAction func get(_ sender: Any) {
    coredata.getActivities { [weak self] activities in
       print("get activities:", activities)
    }
      print("get:")
    }
    
  }
  
  
//}
