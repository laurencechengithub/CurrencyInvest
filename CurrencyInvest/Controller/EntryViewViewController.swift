//
//  EntryViewViewController.swift
//  CurrencyInvest
//
//  Created by Laurence  Chen on 2019/1/4.
//  Copyright © 2019 Laurence  Chen. All rights reserved.
//

import UIKit
import SwiftSpinner
import SystemConfiguration

class EntryViewViewController: UIViewController {
    
    let entryViewViewModel = EntryViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.black
    }
    
   
    
    override func viewDidAppear(_ animated: Bool) {
        SwiftSpinner.show(duration: 1.8, title: "Loading")
        //adding isConnectedToNetWork() in viewDidLoad will cause alertView not in window hierarchy issue
        
        
        if isConnectedToNetWork() {
            dPrint("Internet Connection Available!")
            getCurrency()
//            toCurrencyView()
//            getBitHistory()
        } else {
//            perform(<#T##aSelector: Selector##Selector#>, with: <#T##Any?#>, afterDelay: <#T##TimeInterval#>)
            delayFor(seconds: 2) {
                self.showOffLineAlert()
            }
            
        }
    }
    
//MARK: Check Network
    func isConnectedToNetWork() -> Bool {
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        /* Only Working for WIFI
         let isReachable = flags == .reachable
         let needsConnection = flags == .connectionRequired
         
         return isReachable && !needsConnection
         */
        
        // Working for Cellular and WIFI
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        let resultInBool = (isReachable && !needsConnection)
        
        return resultInBool
        
    }
    
    
    
    func showAlert(string:String) {
        
        let actionOffline = UIAlertAction(title: "OK", style: .default) { (_) in
            Global.isOffLineMode = true
            
            self.toCurrencyView()
        }
        
        let alert = UIAlertController(title: "Internet fail!", message: "Click OK For OffLine mode", preferredStyle: .alert)
        
        alert.addAction(actionOffline)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showOffLineAlert() {
        let actionOpenURL = UIAlertAction(title: "Settings", style: .default) { (_) in
            
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingURL) {
                Global.isToSetting = true
                UIApplication.shared.open(settingURL, completionHandler: { (bool) in
                    dPrint("Settings opened: \(bool)")
                })
            }
            
        }
        
        let actionOffline = UIAlertAction(title: "Continue", style: .default) { (_) in
            
            Global.isOffLineMode = true
            self.toCurrencyView()
        }
        
        
        let alert = UIAlertController(title: "Internet not Available!", message: "Please connect to network", preferredStyle: .alert)
        
        alert.addAction(actionOpenURL)
        alert.addAction(actionOffline)
        self.present(alert, animated: true, completion: nil)
    }
    


    func getCurrency () {
//        getBitCoin()
//        getBitHistory()

        entryViewViewModel.getQuotes()
        entryViewViewModel.quotesCompleteHandler = { (bool) in

            if bool == true {
                DispatchQueue.main.async {
                    self.toCurrencyView()
                }
            } else {
                self.showAlert(string: "Get Currency Fail")
            }
        }
        
    }
    
    
    func toCurrencyView() {
        
        if UserDefualtManager.sharedInstance.isFirstTimeEnterApp == true && Global.isOffLineMode == true {
            
            let alertVC = UIAlertController(title: "1st time enter App",
                                            message: "please make sure internet connection \n and restart app",
                                            preferredStyle: .alert)
            let actionOpenURL = UIAlertAction(title: "Settings", style: .default) { (_) in
                
                guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingURL) {
                    Global.isToSetting = true
                    UIApplication.shared.open(settingURL, completionHandler: { (bool) in
                        dPrint("Settings opened: \(bool)")
                    })
    
                }
            }
            
            
            alertVC.addAction(actionOpenURL)
            self.present(alertVC, animated: true, completion: nil)
        }
        
//        entryViewViewModel.saveDataToUserDefault()
        self.checkedCoffeeBought()
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let CurrencyVC = mainStoryboard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
        
        self.navigationController?.pushViewController(CurrencyVC, animated: true)
        
    }
    
    func checkedCoffeeBought() {
        
        Global.isCoffeeBought = UserDefualtManager.sharedInstance.isBought
        
    }
    

}
