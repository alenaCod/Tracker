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
    }
  }
  @IBOutlet weak var weightField: UITextField!
  
 
 // var activeField: UITextField?
  var lastOffset: CGPoint!
  var keyboardHeight: CGFloat!
  
  override func viewDidLoad() {
        super.viewDidLoad()
   
    configureTextFields()
   configureTapGesture()
    initNavigation()
    // Observe keyboard change
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
  func initNavigation() {
    self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    self.navigationController?.navigationBar.shadowImage = UIImage()
    self.navigationController?.navigationBar.isTranslucent = true
    self.navigationController?.view.backgroundColor = .clear
  }
//  (void)setResultWithNumber:(int)theNumber{
//  //  _isDecimal = false;
//  //  _resultNumber = 0;
//  if(!_isDecimal){
//  _displayNumber *= 10;
//  _displayNumber += theNumber;
//  _resLabel.text = [NSString stringWithFormat:@"%.0lf",_displayNumber];
//  } else {
//  _resLabel.text = [_resLabel.text stringByAppendingString:[NSString stringWithFormat:@"%d",theNumber]];
//  }
//  _displayNumber = [_resLabel.text doubleValue];
//  }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  @IBAction func save(_ sender: UIBarButtonItem) {
    currentUser.name = nameField.text ?? ""
  currentUser.height = heightField.text?.toInt()
    currentUser.weight = weightField.text?.toDouble()
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
//
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
  
  
//  func returnTextView(gesture: UIGestureRecognizer) {
//    guard activeField != nil else {
//      return
//    }
////
//    activeField?.resignFirstResponder()
//    activeField = nil
//  }
}
//
  extension ProfileViewController:UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
      return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
 
      textField.resignFirstResponder()
      return true
    }

}

//extension ProfileViewController {
//
//  @objc func keyboardWillShow(notification:NSNotification){
//    self.scrollView.isScrollEnabled = true
//    var info = notification.userInfo!
//    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//    let contentInsets:UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)
//    self.scrollView.contentInset = contentInsets
//    self.scrollView.scrollIndicatorInsets = contentInsets
//
//    var aRect: CGRect = self.view.frame
//    aRect.size.height -= keyboardSize!.height
//    if let activeField = self.activeField {
//      if (!aRect.contains(activeField.frame.origin)){
//        self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
//      }
//    }
//  }
//
//   @objc func keyboardWillHide(notification:NSNotification){
//
//    var info = notification.userInfo!
//    let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
//    let contentInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
//    self.scrollView.contentInset = contentInsets
//    self.scrollView.scrollIndicatorInsets = contentInsets
//
//    self.scrollView.isScrollEnabled = false
//
//  }
//}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


