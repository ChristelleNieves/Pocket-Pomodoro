//
//  ViewController.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 5/27/21.
//

import UIKit

class MainViewController: UIViewController {
    
    var focusMinutes = 0
    var breakMinutes = 0
    private let focusLabel = UILabel()
    private let breakLabel = UILabel()
    private let startButton = UIButton()
    private let focusSlider = UISlider()
    private let breakSlider = UISlider()
    private let pomodoroTitle = UILabel()
    private let breakMinutesLabel = UILabel()
    private let focusMinutesLabel = UILabel()
    private let clockImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Main view
        configureViewAppearance()
        
        // Title label
        configurePomodoroTitle()
        setPomodoroTitleConstraints()
        
        // Focus label
        configureFocusLabel()
        setFocusLabelConstraints()
        
        // Focus Slider
        configureFocusSlider()
        setFocusSliderConstraints()
        
        // Focus Minutes Label
        configureFocusMinutesLabel()
        setFocusMinutesLabelConstraints()
        
        // Break label
        configureBreakLabel()
        setBreakLabelConstraints()
        
        // Break Minutes Label
        configureBreakMinutesLabel()
        setBreakMinutesLabelConstraints()
        
        // Break Slider
        configureBreakSlider()
        setBreakSliderConstraints()
        
        // Start button
        configureStartButton()
        setStartButtonConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: Appearance
extension MainViewController {
    
    private func configureViewAppearance() {
        view.backgroundColor = UIColor.black
    }
    
    private func configurePomodoroTitle() {
        pomodoroTitle.text = "Pocket Pomodoro"
        pomodoroTitle.textAlignment = .left
        pomodoroTitle.numberOfLines = 0
        pomodoroTitle.minimumScaleFactor = 0.8
        pomodoroTitle.adjustsFontSizeToFitWidth = true
        pomodoroTitle.lineBreakMode = .byTruncatingTail
        pomodoroTitle.font = UIFont.boldSystemFont(ofSize: 55)
        pomodoroTitle.textColor = UIColor.init(red: 255.0/240.0, green: 0.0/240.0, blue: 92.0/240.0, alpha: 1)
        
        view.addSubview(pomodoroTitle)
    }
    
    private func configureFocusLabel() {
        focusLabel.text = "Focus Time:"
        focusLabel.numberOfLines = 0
        focusLabel.minimumScaleFactor = 0.8
        focusLabel.adjustsFontSizeToFitWidth = true
        focusLabel.lineBreakMode = .byTruncatingTail
        focusLabel.font = UIFont.boldSystemFont(ofSize: 25)
        focusLabel.textColor = UIColor.init(white: 1, alpha: 0.37)
        
        view.addSubview(focusLabel)
    }
    
    private func configureFocusMinutesLabel() {
        focusMinutesLabel.text = String(focusMinutes) + " Minutes"
        focusMinutesLabel.font = UIFont.boldSystemFont(ofSize: 25)
        focusMinutesLabel.textColor = UIColor.init(white: 1, alpha: 0.37)
        
        view.addSubview(focusMinutesLabel)
    }
    
    private func configureFocusSlider() {
        focusSlider.minimumValue = 0
        focusSlider.maximumValue = 60
        focusSlider.isContinuous = true
        focusSlider.thumbTintColor = UIColor.init(white: 1, alpha: 0.37)
        focusSlider.tintColor = UIColor.init(red: 255.0/240.0, green: 0.0/240.0, blue: 92.0/240.0, alpha: 1)
        
        focusSlider.addAction(UIAction(title: "", handler: { action in
            let sliderValue = round(self.focusSlider.value)
            self.focusSlider.value = sliderValue
            self.focusMinutes = Int(sliderValue)
            self.focusMinutesLabel.text = String(Int(sliderValue)) + " Minutes"
            
            // Pass the data to the sessionVC via the tab bar
            let tb = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            tb?.tabBar.sessionVC.focusMinutes = self.focusMinutes
            
        }), for: .valueChanged)
        
        view.addSubview(focusSlider)
    }
    
    private func configureBreakLabel() {
        breakLabel.text = "Break Time:"
        breakLabel.numberOfLines = 0
        breakLabel.minimumScaleFactor = 0.8
        breakLabel.adjustsFontSizeToFitWidth = true
        breakLabel.lineBreakMode = .byTruncatingTail
        breakLabel.font = UIFont.boldSystemFont(ofSize: 25)
        breakLabel.textColor = UIColor.init(white: 1, alpha: 0.37)
        
        view.addSubview(breakLabel)
    }
    
    private func configureBreakMinutesLabel() {
        breakMinutesLabel.text = String(breakMinutes) + " Minutes"
        breakMinutesLabel.font = UIFont.boldSystemFont(ofSize: 25)
        breakMinutesLabel.textColor = UIColor.init(white: 1, alpha: 0.37)
        
        // Pass the data to the sessionVC via the tab bar and open the session vc
        let tb = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        tb?.tabBar.sessionVC.breakMinutes = self.breakMinutes
        
        view.addSubview(breakMinutesLabel)
    }
    
    private  func configureBreakSlider() {
        breakSlider.minimumValue = 5
        breakSlider.maximumValue = 30
        breakSlider.isContinuous = true
        breakSlider.thumbTintColor = UIColor.init(white: 1, alpha: 0.57)
        breakSlider.tintColor = UIColor.init(red: 255.0/240.0, green: 0.0/240.0, blue: 92.0/240.0, alpha: 1)
        
        breakSlider.addAction(UIAction(title: "", handler: { action in
            let sliderValue = round(self.breakSlider.value)
            self.breakSlider.value = sliderValue
            self.breakMinutes = Int(sliderValue)
            self.breakMinutesLabel.text = String(Int(sliderValue)) + " Minutes"
            
        }), for: .valueChanged)
        
        view.addSubview(breakSlider)
    }
    
    private func configureStartButton() {
        
        let config = UIImage.SymbolConfiguration(pointSize: 70, weight: .medium, scale: .default)
        
        startButton.setImage(UIImage(systemName: "checkmark.circle", withConfiguration: config), for: .normal)
        startButton.tintColor = UIColor.init(red: 255.0/240.0, green: 0.0/240.0, blue: 92.0/240.0, alpha: 1)
        
        // Add the action for the start button
        startButton.addAction(UIAction(title: "", handler: { action in
            
            // Pass the data to the sessionVC via the tab bar and open the session vc
            let tb = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            tb?.tabBar.sessionVC.focusMinutes = self.focusMinutes
            tb?.tabBar.sessionVC.breakMinutes = self.breakMinutes
            self.tabBarController?.selectedIndex = 1
            
        }), for: .touchUpInside)
        
        view.addSubview(startButton)
    }
}

// MARK: Constraints
extension MainViewController {
    
    private func setPomodoroTitleConstraints() {
        pomodoroTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pomodoroTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            pomodoroTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            pomodoroTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func setFocusLabelConstraints() {
        focusLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            focusLabel.topAnchor.constraint(equalTo: pomodoroTitle.bottomAnchor, constant: 90),
            focusLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30)
        ])
    }
    
    private func setFocusMinutesLabelConstraints() {
        focusMinutesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            focusMinutesLabel.leadingAnchor.constraint(equalTo: focusLabel.trailingAnchor, constant: 20),
            focusMinutesLabel.topAnchor.constraint(equalTo: pomodoroTitle.bottomAnchor, constant: 90)
        ])
    }
    
    private func setFocusSliderConstraints() {
        focusSlider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            focusSlider.topAnchor.constraint(equalTo: focusLabel.bottomAnchor, constant: 20),
            focusSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            focusSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func setBreakLabelConstraints() {
        breakLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            breakLabel.topAnchor.constraint(equalTo: focusSlider.bottomAnchor, constant: 60),
            breakLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
        ])
    }
    
    private func setBreakMinutesLabelConstraints() {
        breakMinutesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            breakMinutesLabel.leadingAnchor.constraint(equalTo: breakLabel.trailingAnchor, constant: 20),
            breakMinutesLabel.topAnchor.constraint(equalTo: focusSlider.bottomAnchor, constant: 60)
        ])
    }
    
    private func setBreakSliderConstraints() {
        breakSlider.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            breakSlider.topAnchor.constraint(equalTo: breakLabel.bottomAnchor, constant: 20),
            breakSlider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            breakSlider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
    }
    
    private func setStartButtonConstraints() {
        startButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startButton.topAnchor.constraint(equalTo: breakSlider.bottomAnchor, constant: 90),
            startButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 120),
            startButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -120)
        ])
    }
}
