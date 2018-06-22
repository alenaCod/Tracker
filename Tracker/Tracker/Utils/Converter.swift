//
//  Converter.swift
//  Tracker
//
//  Created by Sveta on 6/19/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
class Converter {
  
  private static let secondsPerMinute: Int = 60
  private static let minutesPerHour: Int = 60
  private static let secondsPerHour: Int = 3600
  
  class func stringifySecondCount(_ seconds: Int, useLongFormat: Bool, useLongUnits: Bool = false) -> String {
    var remainingSeconds = seconds
    let hours = remainingSeconds / secondsPerHour
    remainingSeconds -= hours * secondsPerHour
    let minutes = remainingSeconds / secondsPerMinute
    remainingSeconds -= minutes * secondsPerMinute
    if useLongFormat {
      if useLongUnits {
        if hours > 0 {
          return NSString(format: "%d hour %d minutes %d seconds", hours, minutes, remainingSeconds) as String
        } else if minutes > 0 {
          return NSString(format: "%d minutes %d seconds", minutes, remainingSeconds) as String
        } else {
          return NSString(format: "%d seconds", remainingSeconds) as String
        }
      }
      else {
        if hours > 0 {
          return NSString(format: "%d hr %d min %d sec", hours, minutes, remainingSeconds) as String
        } else if minutes > 0 {
          return NSString(format: "%d min %d sec", minutes, remainingSeconds) as String
        } else {
          return NSString(format: "%d sec", remainingSeconds) as String
        }
      }
    }
    else {
      if hours > 0 {
        return NSString(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds) as String
      } else if minutes > 0 {
        return NSString(format: "%02d:%02d:%02d",hours, minutes, remainingSeconds) as String
      } else {
        return NSString(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds) as String
      }
    }
  }
}
