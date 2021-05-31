//
//  TabBarViewController.swift
//  pomodoro-app
//
//  Created by Christelle Nieves on 5/29/21.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    // Create instances of view controllers
    let homeVC = MainViewController()
    let sessionVC = SessionViewController()
    let calendarVC = CalendarViewController()
    let settingsVC = SettingsViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Tab bar appearance
        configureTabBarAppearance()
        
        // Set the icon image for each VC
        homeVC.tabBarItem.image = UIImage(systemName: "slider.horizontal.3")
        sessionVC.tabBarItem.image = UIImage(systemName: "timer")
        calendarVC.tabBarItem.image = UIImage(systemName: "calendar")
        settingsVC.tabBarItem.image = UIImage(systemName: "gear")
        
        // Assign view controllers to the tab bar
        self.setViewControllers([homeVC, sessionVC, calendarVC, settingsVC], animated: false)
    }
}

// MARK: Appearance
extension TabBarViewController {
    
    private func configureTabBarAppearance() {
        tabBar.alpha = 0.87
        tabBar.barTintColor = UIColor.systemGray6
        tabBar.tintColor = UIColor.init(red: 255.0/240.0, green: 0.0/240.0, blue: 92.0/240.0, alpha: 1)
    }
}
