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
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var heightField: UITextField!
  @IBOutlet weak var weightField: UITextField!
  
 
  var activeField: UITextField?
  var lastOffset: CGPoint!
  var keyboardHeight: CGFloat!
  
  override func viewDidLoad() {
        super.viewDidLoad()
    configureTextFields()
    configureTapGesture()
    
    // Observe keyboard change
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func saveButton(_ sender: UIButton) {
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
    
    print("viewWillAppear user name: ", currentUser.name)
    print("viewWillAppear user he: ", currentUser.height)
  }
  private func configureTapGesture() {
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.handleTap))
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc func handleTap() {
    print("Handle tap was called")
    view.endEditing(true)
  }
  
  private func configureTextFields() {
    nameField.delegate = self
    heightField.delegate = self
    weightField.delegate = self
  }
  
  
  func returnTextView(gesture: UIGestureRecognizer) {
    guard activeField != nil else {
      return
    }

    activeField?.resignFirstResponder()
    activeField = nil
  }
}

  extension ProfileViewController:UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
//      activeField = textField
//      lastOffset = self.scrollView.contentOffset
      return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     // view.endEditing(true)
      textField.resignFirstResponder()
      return true
    }
  }

extension ProfileViewController {

  @objc func keyboardWillShow(notification:NSNotification){
    self.scrollView.isScrollEnabled = true
    var info = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    
    var aRect: CGRect = self.view.frame
    aRect.size.height -= keyboardSize!.height
    if let activeField = self.activeField {
      if (!aRect.contains(activeField.frame.origin)){
        self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
      }
    }
  }
  
   @objc func keyboardWillHide(notification:NSNotification){
    
    var info = notification.userInfo!
    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
    let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
    self.scrollView.contentInset = contentInsets
    self.scrollView.scrollIndicatorInsets = contentInsets
    
    self.scrollView.isScrollEnabled = false

  }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


