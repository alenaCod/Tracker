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
    distanceLabel.text = activity.distance.toString()
    durationLabel.text = activity.duration.toString()
  }

}
