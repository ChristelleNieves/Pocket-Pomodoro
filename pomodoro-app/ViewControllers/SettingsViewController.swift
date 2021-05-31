//
//  SettingsViewController.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 5/29/21.
//

import UIKit

class SettingsViewController: UIViewController {

    private let titleLabel = UILabel()
    private let darkModeLabel = UILabel()
    private let darkModeSwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // View appearance
        configureViewAppearance()
        
        // Title label
        configureTitleLabel()
        setTitleLableConstraints()
        
        // Dark mode label
        configureDarkModeLabel()
        setDarkModeLabelConstraints()
        
        // Dark mode switch
        configureDarkModeSwitch()
        setDarkModeSwitchConstraints()
    }
}

// MARK: Appearance
extension SettingsViewController {
    
    private func configureViewAppearance() {
        
        view.backgroundColor = .black
        view.alpha = 0.87
    }
    
    private func configureTitleLabel() {
        
        titleLabel.text = "Settings"
        titleLabel.textColor = .white
        titleLabel.alpha = 0.67
        titleLabel.font = UIFont.systemFont(ofSize: 25)
        
        view.addSubview(titleLabel)
    }
    
    private func configureDarkModeLabel() {
        
        darkModeLabel.text = "Dark Mode"
        darkModeLabel.textColor = .white
        darkModeLabel.alpha = 0.67
        darkModeLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        view.addSubview(darkModeLabel)
    }
    
    private func configureDarkModeSwitch() {
        
        darkModeSwitch.isOn = false
        darkModeSwitch.onTintColor = UIColor.init(red: 186.0/240.0, green: 19.0/240.0, blue: 93.0/240.0, alpha: 1)
        darkModeSwitch.tintColor = .systemPink
        view.addSubview(darkModeSwitch)
    }
}

// MARK: Constraints
extension SettingsViewController {
    
    private func setTitleLableConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }
    
    private func setDarkModeLabelConstraints() {
        
        darkModeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            darkModeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            darkModeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50)
        ])
    }
    
    private func setDarkModeSwitchConstraints() {
        
        darkModeSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            darkModeSwitch.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 60),
            darkModeSwitch.leadingAnchor.constraint(equalTo: darkModeLabel.trailingAnchor, constant: 40)
        ])
    }
}
