//
//  AppDelegate.swift
//  AQM
//
//  Created by bharathi kumar on 08/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
        ImageURLCache.shared.imageURLDict = UserDefaults.getCityImagesUrl()
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = UINavigationController.init(rootViewController: DashboardVC())
        self.window?.makeKeyAndVisible()
        return true
    }
    func applicationWillTerminate(_ application: UIApplication) {

    }
}

