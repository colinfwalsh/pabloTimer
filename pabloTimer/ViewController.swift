//
//  ViewController.swift
//  pabloTimer
//
//  Created by Colin Walsh on 10/16/17.
//  Copyright © 2017 Colin Walsh. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController, KeyPressProtocol, TimerProtocol {
    
    @IBOutlet var mainView: MainView!
    @IBOutlet weak var timerLabel: NSTextField!
    @IBOutlet weak var promptField: NSTextField!
    @IBOutlet weak var clueLabel: NSTextField!
    
    var timer = TimerClass()
    
    func updateDisplay(for timeRemaining: TimeInterval) {
        timerLabel.stringValue = textToDisplay(for: timeRemaining)
    }
    
    private func textToDisplay(for timeRemaining: TimeInterval) -> String {
        if timeRemaining == 0 {
            return "Done"
        }
        
        let minutesRemaining = floor(timeRemaining / 60)
        let secondsRemaining = timeRemaining - (minutesRemaining * 60)
        
        let secondsDisplay = String(format: "%02d", Int(secondsRemaining))
        let timeRemainingDisplay = "\(Int(minutesRemaining)):\(secondsDisplay)"
        
        return timeRemainingDisplay
    }
    
    func setTextcolor(for timeRemaining: TimeInterval) -> NSColor{
        let percentageComplete = 100 - (timeRemaining / 360 * 100)
        
        switch percentageComplete {
        case 0..<50:
            return NSColor.red
        default:
            return NSColor.black
        }
    }
    
    func timeRemainingOnTimer(_ timer: TimerClass, timeRemaining: TimeInterval) {
        updateDisplay(for: timeRemaining)
        timerLabel.backgroundColor = setTextcolor(for: timeRemaining)
    }
    
    func timerHasFinished(_ timer: TimerClass) {
        clueLabel.stringValue = "The clue is: "
        timerLabel.stringValue = "K"
    }
    
    func didPressSpaceKey(child:
        MainView) {
            timer.duration = 120
            timer.startTimer()
            promptField.stringValue = "Press Space for more time"
    }
    
    func didPressEnterKey(child: MainView) {
        timer.resetTimer()
        updateDisplay(for: 120)
        promptField.stringValue = "FIND THE CLUE"
        clueLabel.stringValue = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        promptField.stringValue = "FIND THE CLUE"
        clueLabel.stringValue = ""
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

