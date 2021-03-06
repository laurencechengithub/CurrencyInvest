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
import UserNotifications
import FirebaseInstanceID
import FirebaseMessaging
import SwiftyJSON

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
        let entrySB = UIStoryboard.init(name: "EntryView", bundle: nil)
        let vc = entrySB.instantiateViewController(withIdentifier: "EntryViewViewController") as! EntryViewViewController
        let navigationController:UINavigationController = UINavigationController.init(rootViewController: vc)

        if let window = self.window {
            window.rootViewController = navigationController
        }
        
        //FireBase
        FirebaseApp.configure()
        
        
        //Firebase cloud message
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { granted, error in
                    if granted {
                        dPrint("UNUserNotificationCenter.current().requestAuthorization granted")
                    } else {
                        dPrint("UNUserNotificationCenter.current().requestAuthorization not granted")
                    }
            })
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        
        //shortcupItem
        if let shortCutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
            launchedShortcutItem = shortCutItem
        }
        
        //show sqlite filepath
        print("Documents Directory: ", FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last ?? "Not Found!")
        
//        Global.isToSetting = false
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
//        saveDataToUserDefault ()
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        if Global.isToSetting == true {

            if let vc = window?.rootViewController {
                vc.loadView()
            }
            
        }
        dPrint("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        dPrint(applicationDidBecomeActive)
        
        guard let shortCutItem = launchedShortcutItem else {
            return
        }
        
        //If there is any shortcutItem,that will be handled upon the app becomes active
        _ = handleShortcutItem(item: shortCutItem)
        //We make it nil after perfom/handle method call for that shortcutItem action
        launchedShortcutItem = nil
        
        
    }
    
    
    func saveDataToUserDefault () {
        guard Global.isToSetting == false else {
            return
        }
        
        UserDefualtManager.sharedInstance.masterQuotes = Global.allQuotes
        UserDefualtManager.sharedInstance.masterName = Global.allNames
        UserDefualtManager.sharedInstance.selectedNames = Global.selectedNames
        UserDefualtManager.sharedInstance.selectedQuotes = Global.selectedQuotes
        UserDefualtManager.sharedInstance.selectedAmount = Global.selectedAmounts
        UserDefualtManager.sharedInstance.lastEnterAmount = Global.lastEnterAmount
        UserDefualtManager.sharedInstance.lastIndexPathRow = Global.lastIndexPathRow
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
        
        
        var handled:Bool!
        switch item.type {
        case "com.llng-intl.MoneyXBit.currency":
            let entryViewSB = UIStoryboard.init(name: "EntryView", bundle: Bundle.main)
            let entryViewVC = entryViewSB.instantiateViewController(withIdentifier: "EntryViewViewController") as! EntryViewViewController
            if let homeVC = self.window?.rootViewController as? UINavigationController {
                handled = true
                homeVC.pushViewController(entryViewVC, animated: true)
            }
        default:
            handled = false
            break
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
            dPrint("Link has no url")
            return
        }
        
        dPrint("incoming link url:\(url.absoluteString)")
        
    }
    
    
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if let incomingURL = userActivity.webpageURL {
            dPrint("incoming URL is \(incomingURL)")
            let linkHandled = DynamicLinks.dynamicLinks().handleUniversalLink(incomingURL) { (dynamicLink, error) in
                guard error == nil else {
                    dPrint("Found error: \(String(describing: error?.localizedDescription))")
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
            dPrint("received from custom scheme: \(url.absoluteString)")
            self.handleIncomingDynamicLink(dynamicLink)
            return true
        } else {
            //Maybe handle Google or facebook sign in here
            return false
        }
    }

}


//MARK: Cloud Message Stack
extension AppDelegate {
    
    /// iOS10 以下的版本接收推播訊息的 delegate
    ///
    /// - Parameters:
    ///   - application: _
    ///   - userInfo: _
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        
        // 印出後台送出的推播訊息(JOSN 格式)
        dPrint("userInfo: \(userInfo)")
    }
    
    
    /// iOS10 以下的版本接收推播訊息的 delegate
    ///
    /// - Parameters:
    ///   - application: _
    ///   - userInfo: _
    ///   - completionHandler: _
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // 印出後台送出的推播訊息(JOSN 格式)
        dPrint("userInfo: \(userInfo)")
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    /// 推播失敗的訊息
    ///
    /// - Parameters:
    ///   - application: _
    ///   - error: _
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        dPrint("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    
    /// 取得 DeviceToken，通常 for 後台人員推播用
    ///
    /// - Parameters:
    ///   - application: _
    ///   - deviceToken: _
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // 將 Data 轉成 String
        let deviceTokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        dPrint("deviceTokenString: \(deviceTokenString)")
        
        // 將 Device Token 送到 Server 端...
        
    }
    
    
}

@available(iOS 10, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    /// App 在前景時，推播送出時即會觸發的 delegate
    ///
    /// - Parameters:
    ///   - center: _
    ///   - notification: _
    ///   - completionHandler: _
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        // 印出後台送出的推播訊息(JOSN 格式)
        let userInfo = notification.request.content.userInfo
        var apnIntoJSON = JSON(userInfo as! [String: Any])
        
        dPrint("\(apnIntoJSON["action"])")
        // 可設定要收到什麼樣式的推播訊息，至少要打開 alert，不然會收不到推播訊息
        completionHandler([.badge, .sound, .alert])
    }
    
    /// App 在關掉的狀態下或 App 在背景或前景的狀態下，點擊推播訊息時所會觸發的 delegate
    ///
    /// - Parameters:
    ///   - center: _
    ///   - response: _
    ///   - completionHandler: _
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        // 印出後台送出的推播訊息(JOSN 格式)
        let userInfo = response.notification.request.content.userInfo
        var apnIntoJSON = JSON(userInfo as! [String: Any])
        dPrint("apnIntoJSON: \(apnIntoJSON)")
//        apnIntoJSON: {
//            "google.c.a.udt" : "0",
//            "google.c.a.c_id" : "6898997494058808575",
//            "google.c.a.ts" : "1559710800",
//            "aps" : {
//                "alert" : {
//                    "title" : "Money X Bit",
//                    "body" : "check out BTC price!"
//                }
//            },
//            "gcm.message_id" : "0:1559710800893978%4ccd450b4ccd450b",
//            "action" : "one",
//            "gcm.n.e" : "1",
//            "google.c.a.e" : "1"
//        }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    /// iOS10 含以上的版本用來接收 firebase token 的 delegate
    ///
    /// - Parameters:
    ///   - messaging: _
    ///   - fcmToken: _
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        
        // 用來從 firebase 後台推送單一裝置所必須的 firebase token
        dPrint("Firebase registration token: \(fcmToken)")
    }

    // The callback to handle data message received via FCM for devices running iOS 10 or above.
    func applicationReceivedRemoteMessage(_ remoteMessage: MessagingRemoteMessage) {
        dPrint(remoteMessage.appData)
    }
    
}
