//
//  String+Trackers.swift
//  Tracker
//
//  Created by Sveta on 5/10/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation


extension String {
  
  func toInt() -> Int {
    return Int(self) ?? 0
  }
}

extension String {
  
  func toDouble() -> Double {
    return Double(self) ?? 0.0
  }
}
