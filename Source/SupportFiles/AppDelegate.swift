//
//  AppDelegate.swift
//  Functional
//
//  Created by Adriano Soares on 22/07/17.
//  Copyright © 2017 Adriano Soares. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        let mainViewController     = MainViewController()
        let navController          = UINavigationController(rootViewController: mainViewController)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        return true
    }

}
