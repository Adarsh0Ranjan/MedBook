//
//  SceneDelegate.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var keyWindow: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupKeyWindow(in: windowScene)
    }
    
    func setupKeyWindow(in scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        
        window.rootViewController = HostingController(
            rootView: LandingScreen()
                
        )
        self.keyWindow = window
        window.makeKeyAndVisible()
    }
    
    

    func sceneDidDisconnect(_ scene: UIScene) {
        print("Scene disconnected.")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("Scene became active.")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("Scene will resign active.")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("Scene will enter foreground.")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("Scene entered background.")
    }
}
