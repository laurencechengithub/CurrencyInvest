//
//  AppDelegate.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2018/11/23.
//  Copyright © 2018 Laurence  Chen. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var launchedShortcutItem: UIApplicationShortcutItem?
    enum ShortcutIdentifier: String {
        
        case First
        case Second
        case Dynamic
        
        // MARK: Initializers
        init?(fullNameForType: String) {
            guard let last = fullNameForType.components(separatedBy: ".").last else {
                return nil
            }
            self.init(rawValue: last)
        }
        
        // MARK: Properties
        var type: String {
            return Bundle.main.bundleIdentifier! + ".\(self.rawValue)"
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //shortcupItem
        if let shortCutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortCutItem
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
        
        guard let shortCutItem = launchedShortcutItem else {
            return
        }
        
        //If there is any shortcutItem,that will be handled upon the app becomes active
        _ = handleShortcutItem(item: shortCutItem)
        //We make it nil after perfom/handle method call for that shortcutItem action
        launchedShortcutItem = nil
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
}

// MARK: Force Touch
extension AppDelegate {
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
        completionHandler(handleShortcutItem(item: shortcutItem))
        
    }
    
    
    
    func handleShortcutItem(item: UIApplicationShortcutItem) -> Bool {
        
        var handled = false
        // Verify that the provided shortcutItem's type is one handled by the application.
        guard ShortcutIdentifier(fullNameForType: item.type) != nil else { return false }
        guard let shortCutType = item.type as String? else { return false }
        
        let entryView = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        var reqVC: UIViewController!
        
        switch shortCutType {
        case ShortcutIdentifier.First.type:
            reqVC = entryView.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            
            handled = true
            
        case ShortcutIdentifier.Second.type:
            reqVC = entryView.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
            handled = true
            
        case ShortcutIdentifier.Dynamic.type:
            
            self.handleDynamicAction()
            return true
            
        default:
            print("Shortcut Item Handle func")
        }
        
        if let homeVC = self.window?.rootViewController as? UINavigationController {
            homeVC.pushViewController(reqVC, animated: true)
        } else {
            return false
        }
        
        return handled
        
    }
    
    func handleDynamicAction() {
        print("handleDynamicAction")
//        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: Bundle.main)
//
//        if let homeVC = self.window?.rootViewController as? UINavigationController {
//
//            if let orngVC = mainStoryboard.instantiateViewController(withIdentifier: "OrangeVC") as? OrangeVC {
//
//                orngVC.isItPresentingViaShortcutAction = true
//                homeVC.pushViewController(orngVC, animated: true)
//
//            }
//
//        }
    }
}

// MARK: Dynamic Link
extension AppDelegate {
    
    func handleIncomingDynamicLink(_ dynamicLink: DynamicLink ) {
        guard let url = dynamicLink.url else {
            print("Link has no url")
            return
        }
        
        print("incoming link url:\(url.absoluteString)")
        
    }
    
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            print("incoming URL is \(incomingURL)")
            let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { (dynamicLink, error) in
                guard error == nil else {
                    print("Found error: \(String(describing: error?.localizedDescription))")
                    return
                }
                
                if let dynamiclink = dynamicLink {
                    self.handleIncomingDynamicLink(dynamiclink)
                }
                
            }
            
            if linkHandled {
                return true
            } else {
                // Maybe do other things with url
                return false
            }
            
        }
        
        return false
        
    }
    
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let dynamicLink = DynamicLinks.dynamicLinks().dynamicLink(fromCustomSchemeURL: url) {
            print("received from custom scheme: \(url.absoluteString)")
            self.handleIncomingDynamicLink(dynamicLink)
            return true
        } else {
            //Maybe handle Google or facebook sign in here
            return false
        }
    }
    
    
}

