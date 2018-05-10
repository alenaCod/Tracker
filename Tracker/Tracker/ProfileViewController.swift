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
//
    // Add touch gesture for contentView
//    self.contentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(returnTextView(gesture:))))
  //}

    
//    _ = Int(self.heightField.text ?? "0")
//    _ = Double(self.weightField.text!)
//    _ = String(self.nameField.text!)

        // Do any additional setup after loading the view.
    }

  override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
  @IBAction func saveButton(_ sender: UIButton) {
    view.endEditing(true)
    
    currentUser.name = nameField.text ?? ""
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    nameField.text = currentUser.name
    
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
      textField.resignFirstResponder()
      return true
    }
  }

extension ProfileViewController {
  @objc func keyboardWillShow(notification:NSNotification){
    
    var userInfo = notification.userInfo!
    var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    keyboardFrame = self.view.convert(keyboardFrame, from: nil)
    
    var contentInset:UIEdgeInsets = self.scrollView.contentInset
    contentInset.bottom = keyboardFrame.size.height
    self.scrollView.contentInset = contentInset
  }
  
  @objc func keyboardWillHide(notification:NSNotification){
    
    let contentInset:UIEdgeInsets = UIEdgeInsets.zero
    self.scrollView.contentInset = contentInset
  }
  
//  @objc func keyboardWillShow(notification:NSNotification){
//    let value = -70
//
//    let contentInset = UIEdgeInsets(top: CGFloat(value), left: 0, bottom: 0, right: 0)
//    UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
//      self?.scrollView.contentInset = contentInset
//      }, completion: nil)
//  }
//
//  @objc func keyboardWillHide(notification:NSNotification){
//    let contentInset = UIEdgeInsets.zero
//    UIView.animate(withDuration: 0.3, animations: { [weak self] () -> Void in
//      self?.scrollView.contentInset = contentInset
//      }, completion: nil)
//  }
  
  
  
  
//  @objc func keyboardWillShow(notification: NSNotification) {
//    let userInfo: NSDictionary = notification.userInfo! as NSDictionary
//    let keyboardInfo = userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue
//    let keyboardSize = keyboardInfo.cgRectValue.size
//    let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//    scrollView.contentInset = contentInsets
//    scrollView.scrollIndicatorInsets = contentInsets
//  }
//
//  @objc func keyboardWillHide(notification: NSNotification) {
//    scrollView.contentInset = .zero
//    scrollView.scrollIndicatorInsets = .zero
//  }
//  func keyboardWillShow(notification: NSNotification) {
//    if keyboardHeight != nil {
//      return
//    }
//
//    if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//      keyboardHeight = keyboardSize.height
//
//      // so increase contentView's height by keyboard height
//      UIView.animate(withDuration: 0.3, animations: {
//        self.constraintContentHeight.constant += self.keyboardHeight
//      })
//
//      // move if keyboard hide input field
//      let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
//      let collapseSpace = keyboardHeight - distanceToBottom
//
//      if collapseSpace < 0 {
//        // no collapse
//        return
//      }
//
//      // set new offset for scroll view
//      UIView.animate(withDuration: 0.3, animations: {
//        // scroll to the position above keyboard 10 points
//        self.scrollView.contentOffset = CGPoint(x: self.lastOffset.x, y: collapseSpace + 10)
//      })
//    }
//  }
//
//  func keyboardWillHide(notification: NSNotification) {
//    UIView.animate(withDuration: 0.3) {
//      self.constraintContentHeight.constant -= self.keyboardHeight
//
//      self.scrollView.contentOffset = self.lastOffset
//    }
//
//    keyboardHeight = nil
//  }
}


  

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


