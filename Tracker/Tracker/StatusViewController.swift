//
//  StatusViewController.swift
//  Tracker
//
//  Created by Sveta on 4/29/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit


class StatusViewController: UIViewController {
  let currentUser = User.sharedInstance

  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("user name: ", currentUser.name)
    print("user he: ", currentUser.height)
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    print("viewWillAppear user name: ", currentUser.name )
    print("viewWillAppear user he: ", currentUser.height)
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

