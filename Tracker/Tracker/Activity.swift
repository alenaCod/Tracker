//
//  Activity.swift
//  Tracker
//
//  Created by Sveta on 5/8/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
import UIKit

class Activity: NSObject {
  var name:String = ""
  var height:Int
  var weight:Double
  
  init (name: String,height:Int,weight:Double){
    self.name = name
    self.height = height
    self.weight = weight// it has a chance so its value can be set!
  }
  
  

}
