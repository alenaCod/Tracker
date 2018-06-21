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
  
  @IBOutlet weak var imgBase: UIView! {
    didSet {
        imgBase.layer.cornerRadius = imgBase.frame.height / 2
        imgBase.clipsToBounds = true
    }
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func updateCell(activity: DBActivity) {
   
    dateLabel.text = activity.data.monthDayYearFormat()
    distanceLabel.text = NSString(format: "%.2lf",activity.distance) as String + "m"
  
    durationLabel.text = Converter.stringifySecondCount(activity.duration.toInt(), useLongFormat: false)
    
    switch activity.typeActivity {
    case 1:
      typeImage.image = UIImage(named: "ic_bike")
    case 2:
      typeImage.image = UIImage(named: "ic_run")
    case 3:
      typeImage.image = UIImage(named: "ic_walk")
    case 4:
      typeImage.image = UIImage(named: "ic_hill")
    default:
      break
    }
  }
}
