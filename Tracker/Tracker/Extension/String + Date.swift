//
//  String + Date.swift
//  Tracker
//
//  Created by Sveta on 6/18/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation

extension Date {
  func monthDayYearFormat() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    return dateFormatter.string(from: self)
  }
}
