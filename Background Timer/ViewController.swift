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
    //    Update time form userDefaults if app was closed
    startTime = userDefaults.object(forKey: START_TIME_KEY) as? Date
    stopTime = userDefaults.object(forKey: STOP_TIME_KEY) as? Date
    timerIsCounting = userDefaults.bool(forKey: COUNTING_KEY)

    if timerIsCounting {
      startTimer()
    } else {
      stopTimer()
      if let start = startTime {
        if let stop = stopTime {
          let time = calcRestartTime(start: start, stop: stop)
          let difference = Date().timeIntervalSince(time)
          setTimeLabel(Int(difference))
        }
      }
    }
  }

  //MARK: - Methods

  /// Updates userDefaults for stopTime
  /// - Parameter date: startTime date
  func setStartTime(date: Date?) {
    startTime = date
    userDefaults.set(startTime, forKey: START_TIME_KEY)
  }

  /// Updates userDefaults for stopTime
  /// - Parameter date: stopTime date
  func setStopTime(date: Date?) {
    stopTime = date
    userDefaults.set(stopTime, forKey: STOP_TIME_KEY)
  }

  /// Updates userDefaults for timerIsCounting
  /// - Parameter value: bool
  func setTimerCounting(_ value: Bool) {
    timerIsCounting = value
    userDefaults.set(timerIsCounting, forKey: COUNTING_KEY)
  }

  /// if there is a value inside startTime, it calculates the difference in milliseconds. If the startTime value is not set, it resets the timer and updates the label via the functions
  @objc func refreshValue() {
    if let start = startTime {
      let difference = Date().timeIntervalSince(start)
      setTimeLabel(Int(difference))
    } else {
      stopTimer()
      setTimeLabel(0)
    }
  }

  /// updates/setups the label
  /// - Parameter value: integer value for the label
  func setTimeLabel(_ value: Int) {
    let time = secToHoursMinSec(value)
    let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
    timeLabel.text = timeString
  }

  /// calculates minutes hours seconds from a time interval in milliseconds
  /// - Parameter ms: time interval - difference in milliseconds
  /// - Returns: hours minutes seconds as integers
  func secToHoursMinSec(_ ms: Int) -> (Int, Int, Int) {
    let hour = ms / 3600
    let min = (ms % 3600) / 60
    let sec = (ms % 3600) % 60
    return (hour, min, sec)
  }

  /// Makes a string for the label
  /// - Parameters:
  ///   - hour: hour
  ///   - min: minutes
  ///   - sec: seconds
  /// - Returns: label string
  func makeTimeString(hour: Int, min: Int, sec: Int) -> String {
    var timeString = ""
    timeString += String(format: "%02d", hour)
    timeString += ":"
    timeString += String(format: "%02d", min)
    timeString += ":"
    timeString += String(format: "%02d", sec)
    return timeString
  }

  /// Stops the timer, changes the Boolean value to false and changes the title and color of the label
  func stopTimer() {
    if scheduledTimer != nil { scheduledTimer.invalidate() }
    setTimerCounting(false)
    startStopButton.setTitle("START", for: .normal)
    startStopButton.setTitleColor(UIColor.systemGreen, for: .normal)
  }

  /// Calculate difference betweeen star time and time of stop
  /// - Parameters:
  ///   - start: start time
  ///   - stop: stop time
  /// - Returns: difference in the form of a time interval
  func calcRestartTime(start: Date, stop: Date) -> Date {
    let difference = start.timeIntervalSince(stop)
    return Date().addingTimeInterval(difference)
  }

  /// Starts timer counting and turns boolean value to true
  func startTimer() {
    scheduledTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
    setTimerCounting(true)
    startStopButton.setTitle("STOP", for: .normal)
    startStopButton.setTitleColor(UIColor.red, for: .normal)
  }

  //MARK: - Actions
  @IBAction func startStopAction(_ sender: Any) {
    if timerIsCounting {
      setStopTime(date: Date())
      stopTimer()
    } else {
      if let stop = stopTime {
        let restartTime = calcRestartTime(start: startTime!, stop: stop)
        setStopTime(date: nil)
        setStartTime(date: restartTime)
      } else {
        setStartTime(date: Date())
      }
      startTimer()
    }
  }

  @IBAction func resetAction(_ sender: Any) {
    setStopTime(date: nil)
    setStartTime(date: nil)
    timeLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
    stopTimer()
  }
}

