//
//  Countdown.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 6/4/21.
//

import Foundation

public protocol CountdownTimerDelegate {
    func timerTick(_ currentTime: Int)
    func timerFinished()
}

public class CountdownTimer {
    
    private var timer: Timer?

    public var delegate: CountdownTimerDelegate?
    
    public var duration: Int = 0
    
    private(set) public var currentTime: Int = 0
    
    private(set) public var isPaused: Bool = false
    
    private(set) public var isRunning: Bool = false
    
    // MARK: - Initialization
    
    init() {
    }
    
    init(_ duration: Int) {
        self.duration = duration
    }
    
    // MARK: Timer Functions
    
    // Start timer
    func start() {
        
        guard !(self.isRunning && !self.isPaused) else { return }
    
        guard self.duration >= 1 else { return }
        
        if self.isPaused {
            self.isPaused = false
        }
        else {
            self.currentTime = self.duration
        }
        
        self.isRunning = true
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            
            self.currentTime -= 1
            self.delegate?.timerTick(self.currentTime)
            
            if self.currentTime == 0 {
                self.stop()
                self.delegate?.timerFinished()
            }
        })
        
        RunLoop.current.add(timer!, forMode: .common)
    }
    
    // Pause timer
    func pause() {
        guard self.isRunning else { return }
        self.isPaused = true
        self.timer?.invalidate()
    }
    
    // Stop timer
    func stop() {
        guard self.isRunning else { return }
        self.isRunning = false
        self.isPaused = false
        self.timer?.invalidate()
    }
}
