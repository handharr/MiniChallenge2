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
        let vc3 = TakeTestViewController()
        
        // Define NavigationController
        let nav1 = UINavigationController(rootViewController: vc1)
        let nav3 = UINavigationController(rootViewController: vc3)
        
        let evaluationStoryboard = UIStoryboard(name: "EvaluationView", bundle: nil)
        let evaluation = evaluationStoryboard.instantiateViewController(identifier: "Evaluation") as! EvaluationViewController
        let nav2 = UINavigationController(rootViewController: evaluation)
        
        nav1.navigationBar.tintColor = .cedarChest
        nav2.navigationBar.tintColor = .cedarChest
        nav3.navigationBar.tintColor = .cedarChest

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
