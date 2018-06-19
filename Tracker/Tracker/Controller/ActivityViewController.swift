//
//  ActivityViewController.swift
//  Tracker
//
//  Created by Sveta on 4/29/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
  
  private let currentActivity = CurrentActivity.sharedInstance
  private let timeManager = TimerManager.sharedInstance
  //@IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var startB: UIButton!

  @IBAction func startButton(_ sender: Any) {

  }

  @IBAction func bikeButton(_ sender: UIButton) {
   currentActivity.type = 1
    activeButton()
  }
  
  @IBAction func runButton(_ sender: UIButton) {
   currentActivity.type = 2
    activeButton()
  }
  
  @IBAction func walk(_ sender: UIButton) {
    currentActivity.type = 3
    activeButton()
  }
  
  @IBAction func car(_ sender: UIButton) {
    currentActivity.type = 4
    activeButton()
  }
  
  func activeButton() {
    startB.isHidden = false
  }
  
  @objc func notActiveButton() {
    startB.isHidden = true
  }
  
  deinit {
    print("ActivityViewController deinit")
    NotificationCenter.default.removeObserver(self)
  }
  
   func initNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(ActivityViewController.notActiveButton), name:NSNotification.Name(rawValue: "ActivityFinished"), object: nil)
   }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initNotifications()
    startB.isHidden = true
  }
  
  override func viewWillAppear(_ animated: Bool) {
   super.viewWillAppear(animated)
   // print("Activity:\(activity)")
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
 

}

//extension ActivityViewController: TimerManagerDelegate {
//  func updateProgress(_ seconds: Int) {
//     timerLabel.text = timeFormatted(second: seconds)
//  }
//  
//  func timerFinished() {
//    
//  }
//  
//  
//}

