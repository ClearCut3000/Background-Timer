//
//  ViewController.swift
//  Background Timer
//
//  Created by Николай Никитин on 04.01.2022.
//

import UIKit

class ViewController: UIViewController {

  //MARK: - Properties
  var timerIsCounting: Bool = false
  var startTime: Date?
  var stopTime: Date?
  let userDefaults = UserDefaults.standard
  let START_TIME_KEY = "startTime"
  let STOP_TIME_KEY = "stopTime"
  let COUNTING_KEY = "countingKey"
  var scheduledTimer: Timer!

  //MARK: - Outlets
  @IBOutlet var timeLabel: UILabel!
  @IBOutlet var startStopButton: UIButton!
  @IBOutlet var resetButton: UIButton!

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
    stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
    timerIsCounting = userDefaults.bool(forKey: COUNTING_KEY )
  }

  //MARK: - Methods
  func setStartTime(date: Date?){
    startTime = date
    userDefaults.set(startTime, forKey: START_TIME_KEY)
  }

  func setStopTime(date: Date?){
    stopTime = date
    userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
  }

  func setTimerCountiong(_ value: Bool){
    timerIsCounting = value
    userDefaults.set(timerIsCounting, forKey: STOP_TIME_KEY)
  }

  @objc func refreshValue(){
    if let start = startTime {
      let difference = Date().timeIntervalSince(start)
      setTimeLabel(Int(difference))
    }
  }

  func setTimeLabel(_ value: Int){
let 
  }

  func secToHoursMinSec(_ ms: Int) -> (Int, Int, Int) {
    let hour = ms / 3600
    let min = (ms % 3600) / 60
    let sec = (ms % 3600) % 60
    return (hour, min, sec)
  }

  func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
var timeString = ""
    timeString += String(format: "%02d", hour)
    timeString += ":"
    timeString += String(format: "%02d", min)
    timeString += ":"
    timeString += String(format: "%02d", sec)
    return timeString
  }

  func stopTimer(){
    if scheduledTimer != nil { scheduledTimer.invalidate() }
    setTimerCountiong(false)
    startStopButton.setTitle("START", for: .normal)
    startStopButton.setTitleColor(UIColor.green, for: .normal)
  }

  func startTimer(){
    scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
    setTimerCountiong(true)
    startStopButton.setTitle("STOP", for: .normal)
    startStopButton.setTitleColor(UIColor.red, for: .normal)
  }
  //MARK: - Actions
  @IBAction func startStopAction(_ sender: Any) {
    if timerIsCounting {
      setStopTime(date: Date())
      stopTimer()
    } else {
      startTimer()
    }
  }

  @IBAction func resetAction(_ sender: Any) {
  }
}

