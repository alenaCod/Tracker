//
//  TimerManager.swift
//  Tracker
//
//  Created by Sveta on 6/19/18.
//  Copyright © 2018 Alena. All rights reserved.
//

import Foundation

protocol TimerManagerDelegate: class {
  func updateProgress(_ seconds: Int)
  func timerFinished()
}

final class TimerManager {
  
  static let sharedInstance = TimerManager()

  fileprivate weak var delegate: TimerManagerDelegate?
  fileprivate var secondsCounter = 0
  fileprivate var timer: Timer?
  
  private init() {
    
  }
  
  func getDuration() -> Int {
    return secondsCounter
  }
  
  func initialize(delegate: TimerManagerDelegate?) {
    self.delegate = delegate
    secondsCounter = 0 
    startTimer()
  }
  
  fileprivate func startTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerManager.performTimer) , userInfo: nil, repeats: true)
  }
  
  @objc fileprivate func performTimer() {
    secondsCounter = secondsCounter + 1
    delegate?.updateProgress(secondsCounter)
  }
  
  func killTimer() {
    timer?.invalidate()
    timer = nil
    secondsCounter = 0
  }
}

