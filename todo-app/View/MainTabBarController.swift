//
//  ViewController.swift
//  todo-app
//
//  Created by Panupong Kukutapan on 29/7/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        setupTabBar()
    }
    
    //MARK:- SET UP
    
    private func setupView() {
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
    }
    
    private func setupTabBar() {
        
        let todoVC = TodoViewController()
        let todoNav = UINavigationController(rootViewController: todoVC)
        todoNav.tabBarItem = UITabBarItem(title: "TODO", image: nil, tag: 0)
        todoNav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: UIControl.State.normal)
        todoNav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
        let doneVC = DoneViewController()
        let doneNav = UINavigationController(rootViewController: doneVC)
        doneNav.tabBarItem = UITabBarItem(title: "DONE", image: nil, tag: 1)
        doneNav.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], for: UIControl.State.normal)
        doneNav.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -16)
        
        tabBar.tintColor = .black
        
        viewControllers = [todoNav, doneNav]
    }
    
}

