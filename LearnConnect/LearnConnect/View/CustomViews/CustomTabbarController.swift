//
//  CustomTabbarController.swift
//  LearnConnect
//
//  Created by Ebuzer Şimşek on 28.11.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tabBar.tintColor = .systemYellow
        
       
        if traitCollection.userInterfaceStyle == .dark {
            tabBar.unselectedItemTintColor = .white
        } else {
            tabBar.unselectedItemTintColor = .gray
        }

        tabBar.barTintColor = traitCollection.userInterfaceStyle == .dark ? .black : .white
        
        let homeVC = MainViewController()
        homeVC.title = "Ana Sayfa"
        homeVC.tabBarItem = UITabBarItem(title: "Ana Sayfa", image: UIImage(systemName: "house"), tag: 0)
        
        let profileVC = SettingsVC()
        profileVC.title = "Profil"
        profileVC.tabBarItem = UITabBarItem(title: "Profil", image: UIImage(systemName: "person"), tag: 1)
        
        viewControllers = [homeVC, profileVC]
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.userInterfaceStyle == .dark {
            tabBar.unselectedItemTintColor = .white
            tabBar.barTintColor = .black
        } else {
            tabBar.unselectedItemTintColor = .gray
            tabBar.barTintColor = .white
        }
    }
}
