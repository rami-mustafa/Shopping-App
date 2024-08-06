//
//  SceneDelegate.swift
//  ShoppingApp
//
//  Created by Rami Mustafa on 27.07.24.
//
import UIKit
import FirebaseAuth


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        // Kullanıcı oturum durumunu dinleyerek ilgili ViewController'ı ayarla
        Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            DispatchQueue.main.async {
                if user != nil {
                    self?.window?.rootViewController = MainTabBarController()
                } else {
                    self?.window?.rootViewController = LoginVC()
                }
                self?.window?.makeKeyAndVisible()
            }
        }
    }


  
}
