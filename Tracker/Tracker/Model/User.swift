//
//  User.swift
//  Tracker
//
//  Created by Sveta on 5/8/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
import UIKit

 final class User {
  static let sharedInstance = User()
  private let defaults: UserDefaults

  private init() {
    defaults = UserDefaults.standard
  }

  var name: String? {
    get {
      return defaults.string(forKey: "name")
    }
    set {
      defaults.set(newValue, forKey: "name")
      defaults.synchronize()
    }
  }
  
  var height: Int? {
    get {
      return defaults.integer(forKey: "height")
    }
    set {
      defaults.set(newValue, forKey: "height")
      defaults.synchronize()
    }
  }
  
  var weight: Double? {
    get {
      return defaults.double(forKey: "weight")
    }
    set {
      defaults.set(newValue, forKey: "weight")
      defaults.synchronize()
    }
  }
}
