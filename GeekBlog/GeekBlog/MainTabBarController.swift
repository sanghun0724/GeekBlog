//
//  MainTabBarController.swift
//  GeekBlog
//
//  Created by sangheon on 2022/01/25.
//

import UIKit

class MainTabBarController:UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .black
        tabBar.isTranslucent =  false
        
    }
    
    private func setupViewController() {
        print("hello")
    }
    
    
    private func templateNavcontroller(unselectedImage:UIImage,selectedImage:UIImage,rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.navigationBar.isTranslucent = false
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)
        return navController
    }
    
}
