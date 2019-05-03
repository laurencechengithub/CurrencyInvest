//
//  AppDelegate.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2018/11/23.
//  Copyright © 2018 Laurence  Chen. All rights reserved.
//

import UIKit
import Firebase
import CoreData

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
        
        //set rootView
        let entryViewVC = EntryViewViewController()
        if let window = self.window {
            window.rootViewController = entryViewVC
        }
        
        //shortcupItem
        if let shortCutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortCutItem
        }
        
        //show sqlite filepath
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        saveDataToUserDefault ()
        
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
    
    
    func saveDataToUserDefault () {
        
        UserDefualtManager.sharedInstance.masterQuotes = Global.allQuotes
        UserDefualtManager.sharedInstance.masterName = Global.allNames
        UserDefualtManager.sharedInstance.selectedNames = Global.selectedNames
        UserDefualtManager.sharedInstance.selectedQuotes = Global.selectedQuotes
        UserDefualtManager.sharedInstance.selectedAmount = Global.selectedAmounts
        
    }
    
    
//    func resetApp() {
//        UIApplication.shared.windows[0].rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
//    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        saveDataToUserDefault ()
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "ExchangeDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
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
            reqVC = entryView.instantiateViewController(withIdentifier: "MainViewController") as! CurrencyViewController
            
            handled = true
            
        case ShortcutIdentifier.Second.type:
            reqVC = entryView.instantiateViewController(withIdentifier: "MainViewController") as! CurrencyViewController
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

