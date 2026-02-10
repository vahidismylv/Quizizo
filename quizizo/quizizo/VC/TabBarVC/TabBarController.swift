//
//  TabBarController.swift
//  quizizo
//
//  Created by Vahid Ismayilov on 02.10.25.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        tabBar.backgroundColor = .white
        
        setupTabBar()
        setupTabBarConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var tabBarFrame = tabBar.frame
        tabBarFrame.size.height = 100
        tabBarFrame.origin.y = view.frame.height - 90
        tabBar.frame = tabBarFrame
    }
    
    private func setupTabBar() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        
        homeVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        homeVC.tabBarItem.tag = 0

        let recordVC = UINavigationController(rootViewController: RecordViewController())
        
        recordVC.tabBarItem = UITabBarItem(
            title: "",
            image: UIImage(systemName: "trophy"),
            selectedImage: UIImage(systemName: "trophy.fill"))
        
        recordVC.tabBarItem.tag = 1
        
        viewControllers = [homeVC, recordVC]
    }
    
    private func setupTabBarConstraints() {
        tabBar.frame.size.height = 90
        
        tabBar.layer.cornerRadius = 20
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = false
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.1
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -3)
        tabBar.layer.shadowRadius = 10
                
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .lightGray
            
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        
    }
    
}
