//
//  PomodoroTimer.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 6/4/21.
//

import Foundation

public protocol PomodoroTimerDelegate {
    func timerTick(_ currentTime: Int)
    func startFocusPeriod()
    func endFocusPeriod()
    func startBreakPeriod()
    func endBreakPeriod()
}

public class PomodoroTimer {
    
     public enum Mode {
        case focus
        case rest
    }
    
    private var timer: CountdownTimer
    
    public var mode: Mode = .focus
    
    public var repeatTimer: Bool = false
    
    public var delegate: PomodoroTimerDelegate?
    
    public var focusPeriodDuration: Int = 0
    
    public var breakPeriodDuration: Int = 0
    
    public var currentTime: Int {
        get {
            return self.timer.currentTime
        }
    }
    
    public var isRunning: Bool {
        get {
            return self.timer.isRunning
        }
    }
    
    public var isPaused: Bool {
        get {
            return self.timer.isPaused
        }
    }
    
    // MARK: - Init
    
    init() {
        self.timer = CountdownTimer()
        self.timer.delegate = self
    }
    
    // MARK: - Start/Stop
    
    public func start() {
        
        if self.timer.isPaused {
            self.timer.start()
        }
        else if !self.timer.isRunning {
            self.mode = .focus
            self.timer.duration = self.focusPeriodDuration
            self.timer.start()
            self.delegate?.startFocusPeriod()
        }
    }
    
    public func pause() {
        self.timer.pause()
    }
    
    public func reset() {
        self.timer.stop()
    }
}

// MARK: - CountdownTimerDelegate

extension PomodoroTimer: CountdownTimerDelegate {
    
    public func timerTick(_ currentTime: Int) {
        self.delegate?.timerTick(currentTime)
    }
    
    public func timerFinished() {
        if self.mode == .focus {
            self.timer.stop()
            self.delegate?.endFocusPeriod()
            
            // Switch to the break timer
            self.mode = .rest
            self.timer.duration = self.breakPeriodDuration
            
            self.timer.start()
            self.delegate?.startBreakPeriod()
        }
        else {
            self.timer.stop()
        }
    }
}
