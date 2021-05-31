//
//  SessionViewController.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 5/27/21.
//

import UIKit
import AVFoundation
import AudioToolbox

class SessionViewController: UIViewController {
    
    var focusMinutes: Int = 0
    var breakMinutes: Int = 0
    var timerStarted: Bool = false
    var timer: Timer = Timer()
    var muted: Bool = false
    
    private let taskTitleLabel = UILabel()
    private let timerLabel = UILabel()
    private let playButton = UIButton()
    private let pauseButton = UIButton()
    private let resetButton = UIButton()
    private let volumeToggleButton = UIButton()
    private var circularViewDuration: TimeInterval = 0
    private var circularProgressBarView: CircularProgressBarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main view
        configureViewAppearance()
        
        // Task title label
        configureTaskTitleLabel()
        setTaskTitleLabelConstraints()
        
        // Circular progress view
        configureCircularProgressBar()
        setCircularProgressBarConstraints()
        
        // Timer label
        configureTimerLabel()
        setTimerLabelConstraints()
        
        // Play button
        configurePlayButton()
        setPlayButtonConstraints()
        
        // Pause button
        configurePauseButton()
        setPauseButtonConstraints()
        
        // Reset button
        configureResetButton()
        setResetButtonConstraints()
        
        // Volume toggle button
        configureVolumeToggleButton()
        setVolumeToggleButtonConstraints()
    }
    
    private func createTimer() {
        
        var minutesLeft = focusMinutes
        var totalSecondsLeft = focusMinutes * 60
        var secondsLeft = totalSecondsLeft % 60
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            if secondsLeft % 60 == 0 {
                if minutesLeft > 0 {
                    minutesLeft -= 1
                }
            }
            
            totalSecondsLeft -= 1
            secondsLeft = totalSecondsLeft % 60
            self.timerLabel.text = String(format: "%02d:%02d", minutesLeft, secondsLeft)
            
            if totalSecondsLeft <= 0 {
                timer.invalidate()
                
                if !self.muted {
                    AudioServicesPlaySystemSound(SystemSoundID(1304))
                }
            }
        }
    }
}

// MARK: Appearance
extension SessionViewController {
    
    private func configureViewAppearance() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        view.backgroundColor = UIColor.black
    }
    
    private func configureTaskTitleLabel() {
        taskTitleLabel.text = "Focus"
        taskTitleLabel.textColor = UIColor.init(white: 1, alpha: 0.50)
        taskTitleLabel.alpha = 0.67
        taskTitleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        view.addSubview(taskTitleLabel)
    }
    
    private func configureCircularProgressBar() {
        
        circularProgressBarView = CircularProgressBarView(frame: .zero)
        circularProgressBarView.createCircularPath()
        view.addSubview(circularProgressBarView)
    }
    
    private func configureTimerLabel() {
        timerLabel.text = String(format: "%02d:00", focusMinutes)
        timerLabel.alpha = 0.67
        timerLabel.textColor = UIColor.init(white: 1, alpha: 0.50)
        timerLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 115, weight: UIFont.Weight.ultraLight)
        view.addSubview(timerLabel)
    }
    
    private func configurePlayButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        
        playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
        playButton.tintColor = UIColor.init(white: 1, alpha: 0.50)
        playButton.alpha = 0.67
        
        playButton.addAction(UIAction(title: "", handler: { action in
            
            if self.timerStarted == false && self.focusMinutes != 0 {
                self.timerStarted = true
                self.createTimer()
                self.circularProgressBarView.progressAnimation(duration: Double(self.focusMinutes * 60))
            }
            
        }), for: .touchUpInside)
        
        view.addSubview(playButton)
    }
    
    private func configureResetButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .medium, scale: .default)
        
        resetButton.setImage(UIImage(systemName: "gobackward", withConfiguration: config), for: .normal)
        resetButton.tintColor = UIColor.init(white: 1, alpha: 0.50)
        resetButton.alpha = 0.67
        
        resetButton.addAction(UIAction(title: "", handler: { action in
            self.timerLabel.text = String(format: "%02d:00", self.focusMinutes)
            self.timer.invalidate()
        }), for: .touchUpInside)
        
        view.addSubview(resetButton)
    }
    
    private func configurePauseButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        
        pauseButton.setImage(UIImage(systemName: "pause.circle", withConfiguration: config), for: .normal)
        pauseButton.tintColor = UIColor.init(white: 1, alpha: 0.50)
        pauseButton.alpha = 0.67
        
        pauseButton.addAction(UIAction(title: "", handler: { action in
            
            if self.timerStarted {
                self.timerStarted = false
                self.timer.invalidate()
            }
            
        }), for: .touchUpInside)
        
        view.addSubview(pauseButton)
    }
    
    private func configureVolumeToggleButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .default)
        
        volumeToggleButton.setImage(UIImage(systemName: "speaker.2", withConfiguration: config), for: .normal)
        volumeToggleButton.tintColor = UIColor.init(white: 1, alpha: 0.50)
        volumeToggleButton.alpha = 0.67
        
        volumeToggleButton.addAction(UIAction(title: "", handler: { action in
            
            if !self.muted {
                self.muted = true
                self.volumeToggleButton.setImage(UIImage(systemName: "speaker.slash", withConfiguration: config), for: .normal)
            }
            else {
                self.muted = false
                self.volumeToggleButton.setImage(UIImage(systemName: "speaker.2", withConfiguration: config), for: .normal)
            }
            
        }), for: .touchUpInside)
        
        view.addSubview(volumeToggleButton)
    }
}

// MARK: Constraints
extension SessionViewController {
    
    private func setTaskTitleLabelConstraints() {
        taskTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            taskTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            taskTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setTimerLabelConstraints() {
        timerLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timerLabel.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 120),
            timerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setPlayButtonConstraints() {
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: timerLabel.bottomAnchor, constant: 135),
            //playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            playButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60)
        ])
    }
    
    private func setPauseButtonConstraints() {
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pauseButton.topAnchor.constraint(equalTo: playButton.topAnchor),
            pauseButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setResetButtonConstraints() {
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            resetButton.topAnchor.constraint(equalTo: playButton.topAnchor),
            //resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            //resetButton.leadingAnchor.constraint(equalTo: pauseButton.trailingAnchor, constant: 30)
            resetButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
        ])
    }
    
    private func setVolumeToggleButtonConstraints() {
        volumeToggleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            volumeToggleButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            volumeToggleButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func setCircularProgressBarConstraints() {
        
        circularProgressBarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            circularProgressBarView.topAnchor.constraint(equalTo: taskTitleLabel.bottomAnchor, constant: 200),
            circularProgressBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
