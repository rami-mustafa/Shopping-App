//
//  MainTabBarController.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 01.08.24.
//


import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        customizeTabBar()
    }

    private func setupViewControllers() {
        viewControllers = [
            createNavController(for: HomeVC(), title: "Home", image: "house"),
            createNavController(for: CheckoutVC(), title: "Cart", image: "cart"),
            createNavController(for: ProductVC(), title: "Favorites", image: "star")
//            createNavController(for: ProfileVC(), title: "Profile", image: "person")
        ]
    }

    private func createNavController(for rootViewController: UIViewController,
                                     title: String,
                                     image: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        rootViewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(systemName: image)
        return navController
    }

    private func customizeTabBar() {
        tabBar.tintColor = .systemGreen
        tabBar.unselectedItemTintColor = .gray
    }
}
