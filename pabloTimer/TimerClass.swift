//
//  TimerClass.swift
//  pabloTimer
//
//  Created by Colin Walsh on 10/16/17.
//  Copyright © 2017 Colin Walsh. All rights reserved.
//

import Foundation

class TimerClass {
    var timer: Timer? = nil
    var startTime: Date?
    var duration: TimeInterval = 120
    var elapsedTime: TimeInterval = 0
    var delegate: TimerProtocol?
    
    var isStopped: Bool {
        return timer == nil && elapsedTime == 0
    }
    
    var isPaused: Bool {
        return timer == nil && elapsedTime > 0
    }
    
    @objc dynamic func timerAction() {
        guard let startTime = startTime else {
            return
        }
        
        elapsedTime = -startTime.timeIntervalSinceNow
        let secondsRemaining = (duration - elapsedTime).rounded()
        
        if secondsRemaining <= 0 {
            resetTimer()
            delegate?.timerHasFinished(self)
        } else {
            delegate?.timeRemainingOnTimer(self, timeRemaining: secondsRemaining)
        }
    }
    
    func startTimer() {
        startTime = Date()
        elapsedTime = 0
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }

    func resumeTimer() {
        startTime = Date(timeIntervalSinceNow: -elapsedTime)
        
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(timerAction),
                                     userInfo: nil,
                                     repeats: true)
        timerAction()
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        
        timerAction()
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        
        startTime = nil
        duration = 120
        elapsedTime = 0
        
        timerAction()
    }
}

protocol TimerProtocol {
    func timeRemainingOnTimer(_ timer: TimerClass, timeRemaining: TimeInterval)
    func timerHasFinished(_ timer: TimerClass)
}
