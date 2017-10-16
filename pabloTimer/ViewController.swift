//
//  ViewController.swift
//  pabloTimer
//
//  Created by Colin Walsh on 10/16/17.
//  Copyright © 2017 Colin Walsh. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController, SpaceKeyPressProtocol, TimerProtocol {
    
    @IBOutlet var mainView: MainView!
    @IBOutlet weak var timerLabel: NSTextField!
    
    var timer = TimerClass()
    
    func updateDisplay(for timeRemaining: TimeInterval) {
        timerLabel.stringValue = textToDisplay(for: timeRemaining)
    }
    
    private func textToDisplay(for timeRemaining: TimeInterval) -> String {
        if timeRemaining == 0 {
            return "Done!"
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
    
    func timeRemainingOnTimer(_ timer: TimerClass, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
    }
    
    func timerHasFinished(_ timer: TimerClass) {
        print("timer finished")
    }
    
    func didPressSpaceKey(child: MainView) {
        timer.resetTimer()
        updateDisplay(for: 120)
    }
    
    func didPressEnterKey(child: MainView) {
        if timer.isPaused {
            timer.resumeTimer()
        } else {
            timer.duration = 120
            timer.startTimer()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateDisplay(for: 120)
        timer.delegate = self
        self.mainView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    


}

