//
//  StatusViewController.swift
//  Tracker
//
//  Created by Sveta on 4/29/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit


class StatusTabelViewController: UIViewController {
  
  var dbActivities = [DBActivity]() {
    didSet {
      tabelView.reloadData()
    }
  }
  
  let coredata = CoreDataManager.sharedInstance
  
  @IBOutlet weak var tabelView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initNavigation()
  }
  
  func initNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    coredata.getActivities {  [weak self] activities in
      DispatchQueue.main.async {
        self?.dbActivities = activities
      }
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension StatusTabelViewController: UITableViewDelegate {
  
}

extension StatusTabelViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dbActivities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TrackerTableViewCell
    
    let dbAtivity = dbActivities[indexPath.row]
    cell.updateCell(activity: dbAtivity)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
  }
}
