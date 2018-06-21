//
//  TrackerTableViewCell.swift
//  Tracker
//
//  Created by Sveta on 6/17/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit

class TrackerTableViewCell: UITableViewCell {

  @IBOutlet weak var distanceLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var durationLabel: UILabel!
  @IBOutlet weak var typeImage: UIImageView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func updateCell(activity: DBActivity) {
   
    dateLabel.text = activity.data.monthDayYearFormat()
    distanceLabel.text = //activity.distance.toString() + "m"
    NSString(format: "%.2lf",activity.distance) as String + "m"
  
    durationLabel.text = Converter.stringifySecondCount(activity.duration.toInt(), useLongFormat: false)
    
    switch activity.typeActivity {
    case 1:
      typeImage.image = #imageLiteral(resourceName: "bike")
    case 2:
      typeImage.image = #imageLiteral(resourceName: "run")
    case 3:
      typeImage.image = #imageLiteral(resourceName: "walk")
    case 4:
      typeImage.image = #imageLiteral(resourceName: "hill1")
    default:
      break
    }
  }
}
