//
//  AppDelegate.swift
//  TipCalculator
//
//  Created by Pann Cherry on 8/25/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rootVC = UINavigationController(rootViewController: TipCalculatorViewController())
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()

        let navigationTitleColor = #colorLiteral(red: 0.3529411765, green: 0.6431372549, blue: 0.4980392157, alpha: 1)

        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationTitleColor, NSAttributedString.Key.font: UIFont(name: "Playball", size: 30) ?? UIFont.systemFont(ofSize: 30)]
            UINavigationBar.appearance().standardAppearance = appearance
        } else {
            UINavigationBar.appearance().tintColor = navigationTitleColor
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: navigationTitleColor]

            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().backgroundColor = .white
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

