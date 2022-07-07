//
//  TabBarController.swift
//  Trivia
//
//  Created by Douglas Eiki Yonemura on 26/06/22.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewController()
    }
        
    func setupViewController() {
        let firstTabTitle = "Categories"
        let firstTabImage = UIImage(systemName: "list.dash")
        let firstTab = CategoriesViewController()
        firstTab.title = firstTabTitle
        let firstNavigationController = UINavigationController(rootViewController: firstTab)
        firstNavigationController.tabBarItem = UITabBarItem(title: firstTabTitle, image: firstTabImage, selectedImage: firstTabImage)
        
        let secondTabTitle = "Random"
        let secondTabImage = UIImage(systemName: "shuffle")
        let secondTab = QuestionViewController()
        secondTab.title = secondTabTitle
        let secondNavigationController = UINavigationController(rootViewController: secondTab)
        secondNavigationController.tabBarItem = UITabBarItem(title: secondTabTitle, image: secondTabImage, selectedImage: secondTabImage)
        
        viewControllers = [firstNavigationController, secondNavigationController]
    }
}
