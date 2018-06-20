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
  
  var currentActivity = CurrentActivity.sharedInstance
  let coredata = CoreDataManager.sharedInstance
  let timeManager = TimerManager.sharedInstance
  @IBOutlet weak var timerLabel: UILabel!
  
  var c1:CLLocationCoordinate2D?
  var c2:CLLocationCoordinate2D?
 
//  var c2:Double
 // var distanceInMeters:Double?
  @IBOutlet weak var theMap: MKMapView!
  
  @IBAction func saveButton(_ sender: UIBarButtonItem) {
    let duration = timeManager.getDuration()
    timeManager.killTimer()
    saveD(duration: duration, completion: { [weak self] in
     // DispatchQueue.main.async {
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ActivityFinished"), object: nil)
          self?.dismiss(animated: true, completion: nil)
      //}
    })

  }
  //  @IBOutlet weak var theLabel: UILabel!
  
  var manager = CLLocationManager()
  var myLocations: [CLLocation] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startButton()
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
      c1 = myLocations[sourceIndex].coordinate
      
      guard let _c1 = c1 else {
        return
      }
      
      //let coordinate0 = CLLocation(latitude:_c1.latitude , longitude: _c1.longitude)
      
      currentActivity.startPoint = (_c1.latitude, _c1.longitude)
 
      
     // currentActivity.startPoint = (self.cor1,self.cor2)
        c2 = myLocations[destinationIndex].coordinate
      guard let _c2 = c2 else {
        return
      }
      //let coordinate1 = CLLocation(latitude:_c2.latitude , longitude: _c2.longitude)
      currentActivity.endPoint = (_c2.latitude, _c2.longitude)
    
      
      var a = [_c1, _c2]
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
  
  
  func getDistance() -> Double {
    guard let _c1 = c1, let _c2 = c2 else {
      return 0
    }
    
    let coordinate1 = CLLocation(latitude:_c1.latitude , longitude: _c1.longitude)
    
    let coordinate2 = CLLocation(latitude:_c2.latitude , longitude: _c2.longitude)
    
    
    let distanceInMeters = coordinate1.distance(from: coordinate2)
    print(String(format: "The distance to my buddy is %lf m", distanceInMeters))
    
    return distanceInMeters
  }
  
  func saveD(duration: Int, completion: @escaping ()->()) {
    guard let _c1 = c1, let _c2 = c2 else {
      completion()
      return
    }

    
    currentActivity.startPoint = (_c1.latitude,_c1.longitude)
    currentActivity.endPoint = (_c2.latitude,_c2.longitude)
   
    currentActivity.date = Date()
    currentActivity.distance = getDistance()
    currentActivity.duration = duration.toInt16()
    coredata.saveActivity(data: currentActivity) { 
      completion()
    }
  }
  
  @IBAction func get(_ sender: Any) {
    coredata.getActivities { [weak self] activities in
       print("get activities:", activities)
    }
      print("get:")
    }
 
  func startButton() {
    timeManager.initialize(delegate: self)
  }
  
  func timeFormatted(second: Int) -> String {
    let seconds: Int = second % 60
    let minutes: Int = (second / 60) % 60
    let hours: Int = second / 3600
    return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
    }
  }

extension MapViewController: TimerManagerDelegate {
  func updateProgress(_ seconds: Int) {
    timerLabel.text = timeFormatted(second: seconds)
  }
  
  func timerFinished() {
    
  }
  
  
}
  
  
//}
