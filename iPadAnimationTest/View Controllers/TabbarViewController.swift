//
//  TabbarViewController.swift
//  iPadAnimationTest
//
//  Created by Cedan Misquith on 15/10/19.
//  Copyright © 2019 Cedan Misquith. All rights reserved.
//

import UIKit

class TabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        //Custom tabbar configuration.
        let mainVC = storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let optimizationVC = storyboard?.instantiateViewController(withIdentifier: "OptimizationViewController")
        let savingsVC = storyboard?.instantiateViewController(withIdentifier: "SavingsViewController")
        let settingsVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController")
        mainVC.tabBarItem.title = "Dashboard"
        mainVC.tabBarItem.image = UIImage(named: "Dashboard")!
        optimizationVC?.tabBarItem.title = "Optimization"
        optimizationVC?.tabBarItem.image = UIImage(named: "Optimization")!
        savingsVC?.tabBarItem.title = "Savings"
        savingsVC?.tabBarItem.image = UIImage(named: "Savings")!
        settingsVC?.tabBarItem.title = "Settings"
        settingsVC?.tabBarItem.image = UIImage(named: "Settings")!
        self.viewControllers = [mainVC, optimizationVC!, savingsVC!, settingsVC!]
        self.tabBar.itemPositioning = .centered
        self.tabBar.tintColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#0D004D")
        self.tabBar.unselectedItemTintColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#808080")
    }
}
