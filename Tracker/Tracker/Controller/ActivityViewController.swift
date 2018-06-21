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
  private let coreDataManager = CoreDataManager.sharedInstance
  // private let timeManager = TimerManager.sharedInstance
  //@IBOutlet weak var timerLabel: UILabel!
  
  
  @IBOutlet weak var startB: UIButton!
  @IBOutlet weak var lTotal: UILabel!
  
  @IBAction func startButton(_ sender: Any) {
    
  }
  
  @IBAction func bikeButton(_ sender: UIButton) {
    currentActivity.initActivity(type: 1)
    activeButton()
  }
  
  @IBAction func runButton(_ sender: UIButton) {
    currentActivity.initActivity(type: 2)
    activeButton()
  }
  
  @IBAction func walk(_ sender: UIButton) {
    currentActivity.initActivity(type: 3)
    activeButton()
  }
  
  @IBAction func car(_ sender: UIButton) {
    currentActivity.initActivity(type: 4) 
    activeButton()
  }
  
  func activeButton() {
    startB.alpha = 1.0
    startB.isUserInteractionEnabled = true
  }
  
  
  
  @objc func notActiveButton() {
    DispatchQueue.main.async {
      self.startB.alpha = 0.7
      self.startB.isUserInteractionEnabled = false
    }
  }
  
  func initNavigation() {
    
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
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
    initNavigation()
    applyRoundCorner(startB)
    
    //startB.layer.cornerRadius = startB.frame.size.height/2
    initNotifications()
    notActiveButton()
  }
  
  func applyRoundCorner(_ object: AnyObject){
    object.layer.cornerRadius = object.frame.width/2
    object.layer.masksToBounds = true
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // print("Activity:\(activity)")
    notActiveButton()
    setupTotalDistance()
  }

  func setupTotalDistance() {
    coreDataManager.getTotalDistance(completion: { [weak self] result in
      print("distance total:", result)
      DispatchQueue.main.async {
        self?.lTotal.text = NSString(format: "%.2lf",result) as String + "m"
      }
    })
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}



