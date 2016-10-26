//
//  AppDelegate.swift
//  ShortcutSample
//
//  Created by Shohei Yokoyama on 2016/10/26.
//  Copyright © 2016年 Shohei Yokoyama. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
         Detail https://developer.apple.com/reference/uikit/uiapplicationshortcutitem#//apple_ref/doc/uid/TP40016501-CH1-SW8
         
         type: identifier
         
         userInfo: version identifier
            If a user installs an update for your app but has not yet launched the update, pressing your Home screen icon shows the dynamic quick actions for the previously-installed version. One way to gracefully handle this scenario is to provide app version information in the userInfo dictionary of a quick action.
         Apple Doc.
        
        */
        
        if application.shortcutItems?.isEmpty == true {
            let shortcut1 = UIMutableApplicationShortcutItem(type: ShortcutType.first.type, localizedTitle: "title-first", localizedSubtitle: "sub-title-first", icon: nil, userInfo: ["applicationVerionKey":  AppDelegate.appVersion])
            let shortcut2 = UIMutableApplicationShortcutItem(type: ShortcutType.second.type, localizedTitle: "title-second", localizedSubtitle: "sub-title-second", icon: nil, userInfo: ["applicationVerionKey":  AppDelegate.appVersion])
            let shortcut3 = UIMutableApplicationShortcutItem(type: ShortcutType.third.type, localizedTitle: "title-third", localizedSubtitle: "sub-title-third", icon: nil, userInfo: ["applicationVerionKey":  AppDelegate.appVersion])
            application.shortcutItems = [shortcut1, shortcut2, shortcut3]
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
    
    // MARK: Continuing User Activity and Handling Quick Actions
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(handleShortCutItem(shortcutItem: shortcutItem))
    }
}

// MARK: Continuing User Activity and Handling Quick Actions

extension AppDelegate {
    
    enum ShortcutType: String {
        case first, second, third
        
        init?(fullType: String?) {
            guard let last = fullType?.components(separatedBy: ".").last else { return nil }
            
            self.init(rawValue: last)
        }
        
        
        var type: String {
            return Bundle.main.bundleIdentifier! + "." + rawValue
        }
    }
    
    fileprivate func handleShortCutItem(shortcutItem item: UIApplicationShortcutItem) -> Bool {
        guard let type = ShortcutType(fullType: item.type) else { return false }
        
        switch type {
        case .first:
            // Handle shortcut 1 (static).
            print("first.type")
        case .second:
            // Handle shortcut 2 (static).
            print("second.type")
        case .third:
            // Handle shortcut 3 (dynamic).
            print("third.type")
            
        }
        return true
    }
}

