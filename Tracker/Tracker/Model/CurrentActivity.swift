//
//  Activity.swift
//  Tracker
//
//  Created by Sveta on 6/13/18.
//  Copyright © 2018 Alena. All rights reserved.
//
import Foundation
import UIKit

class CurrentActivity {
  static let sharedInstance = CurrentActivity()
  var type: Int?
  var duration: Int16?
  var distance: Double?
  var date: Date?
  var startPoint: (latitude: Double, longitude: Double)?
  var endPoint: (latitude: Double, longitude: Double)?
}
