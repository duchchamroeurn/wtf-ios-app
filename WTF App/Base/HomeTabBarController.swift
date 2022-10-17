//
//  HomeTabBarController.swift
//  WTF App
//
//  Created by DUCH Chamroeun on 13/10/22.
//

import UIKit

final class HomeTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createViewControllers()
    }
    
    private func createViewControllers() {
        
        let homeViewController = HomeViewController.createViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "menucard.fill"), selectedImage: nil)
        
        let orderHistoryViewController = OrderHistoryViewController.createViewController()
        orderHistoryViewController.tabBarItem =  UITabBarItem(tabBarSystemItem: .history, tag: 1)
        
        let userProfileViewController = UserProfileViewController.createViewController()
        userProfileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle"), selectedImage: nil)
        
        let viewControllers = [homeViewController,orderHistoryViewController,userProfileViewController].map({UINavigationController(rootViewController: $0)})
        self.viewControllers = viewControllers
    }

}
