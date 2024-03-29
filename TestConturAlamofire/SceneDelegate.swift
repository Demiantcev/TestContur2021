//
//  SceneDelegate.swift
//  TestConturAlamofire
//
//  Created by Кирилл Демьянцев on 23.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let nc = UINavigationController(rootViewController: MyPageViewController())
        window.rootViewController = nc
        window.makeKeyAndVisible()
        self.window = window
    }
}

