//
//  ActivityViewController.swift
//  Tracker
//
//  Created by Sveta on 4/29/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController {
  
  let currentActivity = CurrentActivity.sharedInstance
  @IBOutlet weak var timerLabel: UILabel!
  
  @IBOutlet weak var startB: UIButton!
  
  var countTimer = Timer()
  var second = 0
  
  @IBAction func stopButton(_ sender: Any) {
    countTimer.invalidate()
    second = 0
    timerLabel.text = timeFormatted(_second: second)
  }
  
  @IBAction func startButton(_ sender: Any) {
    countTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ActivityViewController.updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc func updateTimer() {
    second += 1
    timerLabel.text = timeFormatted(_second: second)
  }
  
  func timeFormatted(_second: Int) -> String {
    let seconds: Int = second % 60
    let minutes: Int = (second / 60) % 60
    let hours: Int = second / 3600
    return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    startB.isHidden = true
    

    // Do any additional setup after loading the view, typically from a nib.
  }
  override func viewWillAppear(_ animated: Bool) {
   super.viewWillAppear(animated)
   // print("Activity:\(activity)")
  }
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
 
 

}

