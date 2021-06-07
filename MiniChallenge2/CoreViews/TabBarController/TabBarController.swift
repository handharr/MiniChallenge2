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
        
        nav1.tabBarItem = UITabBarItem(title: "My Plan", image: UIImage(systemName: "list.bullet"), tag: 1)
        nav2.tabBarItem = UITabBarItem(title: "Evaluation", image: UIImage(systemName: "doc.text.fill"), tag: 2)
        nav3.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), tag: 3)
        
        nav1.tabBarItem.selectedImage = UIImage(systemName: "square.and.arrow.up.fill")
        nav2.tabBarItem.selectedImage = UIImage(systemName: "square.and.arrow.down.fill")
        nav3.tabBarItem.selectedImage = UIImage(systemName: "square.and.arrow.up.fill")
        
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2, nav3], animated: false)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
