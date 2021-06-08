//
//  TabBarController.swift
//  MiniChallenge2
//
//  Created by Puras Handharmahua on 03/06/21.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define ViewController
        let vc1 = MyPlanViewController()
        let vc2 = EvaluationViewController()
        let vc3 = ProfileViewController()
        
        // Define NavigationController
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav2 = UINavigationController(rootViewController: vc2)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        nav1.navigationBar.tintColor = .label
        nav2.navigationBar.tintColor = .label
        nav3.navigationBar.tintColor = .label
        
        nav1.tabBarItem = UITabBarItem(title: "My Plan", image: UIImage(named: "myplan"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Evaluation", image: UIImage(named: "evaluation"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        
        nav1.tabBarItem.selectedImage = UIImage(named: "myplan-fill")
        nav2.tabBarItem.selectedImage = UIImage(named: "evaluation-fill")
        nav3.tabBarItem.selectedImage = UIImage(named: "profile-fill")
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        tabBar.tintColor = MCColor.MCColorPrimary
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
}
