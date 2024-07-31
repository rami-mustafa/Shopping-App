//
//  SceneDelegate.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = RegisterVC()
        self.window = window
        self.window?.makeKeyAndVisible()
//        configureNavigationBar()
    }

    // MARK: - Create Navigation Controllers

    func createHomeNC() -> UINavigationController {
        let homeVC = HomeVC()
        homeVC.title = "Home"
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }

    func createCartNC() -> UINavigationController {
        let cartVC = CartVC()
        cartVC.title = "Cart"
        cartVC.tabBarItem = UITabBarItem(title: "Cart", image: UIImage(systemName: "cart"), tag: 1)
        return UINavigationController(rootViewController: cartVC)
    }

    func createProfileNC() -> UINavigationController {
        let profileVC = ProfileVC()
        profileVC.title = "Profile"
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 2)
        return UINavigationController(rootViewController: profileVC)
    }

    func createFavoritesNC() -> UINavigationController {
        let favoriteVC = FavoriteVC()
        favoriteVC.title = "Favorites"
        favoriteVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), tag: 3)
        return UINavigationController(rootViewController: favoriteVC)
    }

    // MARK: - Create Tab Bar Controller

    func createTabBar() -> UITabBarController {
          let tabBar = UITabBarController()
          tabBar.setValue(CustomTabBar(), forKey: "tabBar")
          UITabBar.appearance().tintColor = .systemGreen
          tabBar.viewControllers = [createHomeNC(), createCartNC(), createFavoritesNC(), createProfileNC()]
          return tabBar
      }

    // MARK: - Configure Navigation Bar

    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
}
