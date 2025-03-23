//
//  AppDelegate.swift
//  MedBook
//
//  Created by Adarsh Ranjan on 23/03/25.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        print("App has launched successfully.")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("App will resign active.")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("App entered background.")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("App will enter foreground.")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print("App became active.")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("App will terminate.")
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
