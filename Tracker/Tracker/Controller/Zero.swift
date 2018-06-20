//
//  Zero.swift
//  Tracker
//
//  Created by Sveta on 6/20/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation
class Zero {
  
 fileprivate var displayNumber = 0
   static let sharedInstance = Zero()
  
  func result(_ theNumber:Int) -> String {
    displayNumber *= 10
    displayNumber += theNumber
    return NSString(format: "%d",displayNumber) as String
  }
  //  (void)setResultWithNumber:(int)theNumber{
  //  //  _isDecimal = false;
  //  //  _resultNumber = 0;
  //  if(!_isDecimal){
  //  _displayNumber *= 10;
  //  _displayNumber += theNumber;
  //  _resLabel.text = [NSString stringWithFormat:@"%.0lf",_displayNumber];
  //  } else {
  //  _resLabel.text = [_resLabel.text stringByAppendingString:[NSString stringWithFormat:@"%d",theNumber]];
  //  }
  //  _displayNumber = [_resLabel.text doubleValue];
  //  }

}
