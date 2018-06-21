//
//  ProfileViewController.swift
//  Tracker
//
//  Created by Sveta on 5/2/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import UIKit


class ProfileViewController: UIViewController {

  let currentUser = User.sharedInstance
  
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameField: UITextField! {
    didSet {
      nameField.layer.borderColor = UIColor.white.cgColor
      nameField.layer.borderWidth = 1
      nameField.layer.cornerRadius = 7
    }
  }
  @IBOutlet weak var heightField: UITextField! {
    didSet {
      heightField.addTarget(self, action: #selector(ProfileViewController.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
      heightField.layer.borderColor = UIColor.white.cgColor
      heightField.layer.borderWidth = 1
      heightField.layer.cornerRadius = 7
    }
  }
  @IBOutlet weak var weightField: UITextField! {
    didSet {
      weightField.layer.borderColor = UIColor.white.cgColor
      weightField.layer.borderWidth = 1
      weightField.layer.cornerRadius = 7
    }
  }
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    configureTextFields()
    configureTapGesture()
    initNavigation()
    }
  
  func initNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func save(_ sender: UIBarButtonItem) {
    view.endEditing(true)
    currentUser.name = nameField.text ?? ""
    currentUser.height = heightField.text?.toInt()
    currentUser.weight = weightField.text?.toDouble()
  }
  
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    nameField.text = currentUser.name
    heightField.text = currentUser.height?.toString()
    weightField.text = currentUser.weight?.toString()
    
//    print("viewWillAppear user name: ", currentUser.name)
//    print("viewWillAppear user he: ", currentUser.height)
  }
  
  private func configureTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func handleTap() {
    print("Handle tap was called")
    view.endEditing(true)
  }
//
  private func configureTextFields() {
    nameField.delegate = self
    heightField.delegate = self
    weightField.delegate = self
  }

  
  @objc func textFieldDidChange(_ textField: UITextField) {
    textField.text = textField.text?.toInt().toString()
  }
}

  extension ProfileViewController:UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
      return true
    }

}


