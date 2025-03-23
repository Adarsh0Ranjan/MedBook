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
    var progressLoaderWindow: UIWindow?
    var alertViewWindow: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        setupKeyWindow(in: windowScene)
        setupProgressLoaderWindow(in: windowScene)
        setupAlertViewWindow(in: windowScene)
    }
    
    func setupKeyWindow(in scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        
        window.rootViewController = HostingController(
            rootView: LandingScreen()
                
        )
        self.keyWindow = window
        window.makeKeyAndVisible()
    }
    
    func setupProgressLoaderWindow(in scene: UIWindowScene) {
        let progressLoaderWindow = PassThroughWindow(windowScene: scene)
        let progressLoaderViewController = HostingController(
            rootView: ActivityIndicator()
        )
        progressLoaderViewController.view.backgroundColor = .clear
        progressLoaderWindow.rootViewController = progressLoaderViewController
        progressLoaderWindow.isHidden = false
        self.progressLoaderWindow = progressLoaderWindow
    }
    
    func setupAlertViewWindow(in scene: UIWindowScene) {
        let alertViewWindow = PassThroughWindow(windowScene: scene)
        let alertViewController = HostingController(
            rootView: AlertView()
        )
        alertViewController.view.backgroundColor = .clear
        alertViewWindow.rootViewController = alertViewController
        alertViewWindow.isHidden = false
        self.alertViewWindow = alertViewWindow
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
