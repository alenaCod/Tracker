//
//  DBActivity.swift
//  Tracker
//
//  Created by Sveta on 6/15/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
import CoreData

final class DBActivity: NSManagedObject {
  
  @NSManaged private(set) var data: Date
  @NSManaged private(set) var distance: Double
  @NSManaged private(set) var duration: Int16
  @NSManaged private(set) var endLatitude: Double
  @NSManaged private(set) var endLongitude: Double
  @NSManaged private(set) var startLatitude: Double
  @NSManaged private(set) var startLongitude: Double
  @NSManaged private(set) var typeActivity: Int16
  
  @discardableResult
  static func insert(into context: NSManagedObjectContext, item: CurrentActivity) -> DBActivity? {
    
    var activity: DBActivity?
    
    activity = context.insertObject()
    
    if let _data = item.date {
      activity?.data = _data
    }
    
    if let _dist = item.distance {
      activity?.distance = _dist
    }
    
    if let _dur = item.duration {
      activity?.duration = _dur
    }
    
    if let _endLat = item.endPoint?.latitude {
      activity?.endLatitude = _endLat
    }
    
    if let _endLong = item.endPoint?.longitude {
      activity?.endLongitude = _endLong
    }
    
    if let _startLat = item.startPoint?.latitude {
      activity?.startLatitude = _startLat
    }
    
    if let _startLong = item.startPoint?.longitude {
      activity?.startLongitude = _startLong
    }
    
    if let _active = item.type?.toInt16() {
      activity?.typeActivity = _active
    }
    return activity
  }
}

extension DBActivity: Managed {
  static var defaultSortDescriptors: [NSSortDescriptor] {
    return [NSSortDescriptor(key: #keyPath(data), ascending: false)]
  }
}
