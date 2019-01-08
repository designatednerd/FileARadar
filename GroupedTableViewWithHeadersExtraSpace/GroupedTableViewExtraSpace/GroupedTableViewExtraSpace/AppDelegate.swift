//
//  AppDelegate.swift
//  GroupedTableViewExtraSpace
//
//  Created by Ellen Shapiro (Work) on 6/10/18.
//  Copyright © 2018 DesignatedNerd. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {

        let outerNav = UINavigationController(rootViewController: ExampleSelectionViewController())

        let tabBarController = UITabBarController()

        tabBarController.setViewControllers([outerNav], animated: false)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()

        return true
    }
}

