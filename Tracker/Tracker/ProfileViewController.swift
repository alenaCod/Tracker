//
//  ProfileViewController.swift
//  Tracker
//
//  Created by Sveta on 5/2/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {

  @IBOutlet weak var nameField: UITextField!
  
  @IBOutlet weak var heightField: UITextField!
  
  @IBOutlet weak var weightField: UITextField!
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    _ = Int(self.heightField.text!)
    _ = Double(self.weightField.text!)
    _ = String(self.nameField.text!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  

  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
